import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:shop_app/api/order_api.dart";
import 'package:shop_app/widgets/mydrawer.dart';

import "../providers/orders.dart";
import "../widgets/order_item.dart";

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = "orders screen";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<void> _refresh(BuildContext context) async {
    await OrderApi.getOrders();
  }

  @override
  void initState() {
    OrderApi.getOrders();
    super.initState();
    // Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Added Orders")),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: Consumer<OrderProvider>(
          builder: ((context, orderProvider, child) {
            if(orderProvider.loader) return const Center(child: CircularProgressIndicator(),);
            if(orderProvider.orders.isEmpty) return const Center(child: Text("No Orders"),);
            return ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                return OrderItem(
                  order: orderProvider.orders[index],
                );
              },
            );
          }),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
