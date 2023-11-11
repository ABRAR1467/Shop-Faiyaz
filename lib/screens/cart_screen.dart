import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/api/order_api.dart';
import 'package:shop_app/models/order_model.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = "cart-screen";

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          num total = 0;
          for(int i = 0; i < cartProvider.cartsItems.length; i++){
            total += (cartProvider.cartsItems[i].product.price??0) * (cartProvider.cartsItems[i].quantity??0);
          }
        return Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total", style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      total.toStringAsFixed(2),
                      style: TextStyle(
                        color:
                            Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  const SizedBox(width: 10),
                  OrderButton()
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartsItems.length,
              itemBuilder: (context, index) {
                return ACartItem(
                  cart: cartProvider.cartsItems[index],
                 
                );
              },
            ),
          ),
        ],
      );
        },
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({super.key});


  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return TextButton(
        onPressed: (CartProvider().cartsItems.length??0 )<= 0 || orderProvider.loader
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });

                // await Provider.of<Orders>(context, listen: false).addOrder(
                //   widget.cartData.items.values.toList(),
                //   widget.cartData.totalPrice,
                // );
                num total=0;
                for(int i = 0; i < CartProvider().cartsItems.length; i++){
                  total += ((CartProvider().cartsItems[i].product.price??0) * (CartProvider().cartsItems[i].quantity??0));
                }
                OrderApi.addOrder(
                  orderModel: OrderModel(
                    products: CartProvider().cartsItems.map((e) => e.product).toList(), 
                  quantities: CartProvider().cartsItems.map((e) => e.quantity).toList(), 
                  total: total, status: "Order Placed"),
                );

                setState(() {
                  _isLoading = false;
                });

                CartProvider().clearCart();
              },
        child: orderProvider.loader
            ? const SizedBox(
                height: 20, width: 20, child: CircularProgressIndicator())
            : const Text("ORDER NOW"));
      },
    );
  }
}
