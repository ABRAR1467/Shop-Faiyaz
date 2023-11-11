import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "package:shop_app/models/order_model.dart";
import "dart:math";

import "../providers/orders.dart";

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded
          ? min((widget.order.products?.length??0) * 20.0 + 102, 220)
          : 95,
      child: Card(
        color: Colors.orange,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.order.total.toString()??"n/a]",
              ),
              subtitle: Text(
              DateFormat("dd/MM/yyyy hh:mm").format(DateTime.parse(widget.order.createdAt??"")),
              
              
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              color: Colors.black26,
              height: _expanded
                  ? min((widget.order.products?.length??0) * 20.0 + 10, 100)
                  : 0,
              child: ListView(
                children: widget.order.products?.map(
                      (prod) {
                        int index = widget.order.products?.indexWhere((e) => e.id == prod.id)??0;
                        return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prod.name??"[n/a]",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${widget.order.quantities?[index].toString()??"0"}x \$${prod.price?.toString()??"0"}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      );},
                    ).toList()??[],
              ),
            )
          ],
        ),
      ),
    );
  }
}
