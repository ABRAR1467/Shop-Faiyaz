import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/cart.dart';

class ACartItem extends StatelessWidget {
 ACartItem({Key? key,required this.cart})
      : super(key: key);
  
  CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(cart.product.id),
      background: Container(
        color: Colors.red,
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: const Icon(Icons.delete_sweep),
        ),
      ),
      onDismissed: (direction) {
        CartProvider().removeProduct(cart.product);
        // Provider.of<Cart>(context, listen: false).removeItem(prodId);
      },
      confirmDismiss: (direcion) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: Text(
                "Do you want to remove ${cart.product.name?.toUpperCase()??"[n/a]"} from the cart? "),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes", style: TextStyle(fontSize: 20)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No", style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: FittedBox(
                child: Text(
                  cart.product?.price?.toString()??"[n/a]",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            title: Text(cart.product?.name?.toString()??"[n/a]"),
            subtitle: Text("Total: ${((cart.product.price??0) * (cart.quantity??0)).toStringAsFixed(2)}"),
            trailing: Text("${cart.quantity?.toString()??"[n/a]"}x"),
          ),
        ),
      ),
    );
  }
}
