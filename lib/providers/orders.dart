import 'dart:convert';

import "package:flutter/material.dart";
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/providers/cart.dart';
import "package:http/http.dart" as http;

class OrderProvider with ChangeNotifier {
  bool loader = false;
  List<OrderModel> orders = [];

  void setOrders(List<OrderModel> orders) {
    this.orders = orders;
    notifyListeners();
  }

  void setLoader(bool loader) {
    this.loader = loader;
    notifyListeners();
  }

  static final _instance = OrderProvider._internal();
  OrderProvider._internal();
  factory OrderProvider() => _instance;
}
