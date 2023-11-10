import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import "dart:convert";

import "package:shop_app/models/product_model.dart";

class ProductProvider with ChangeNotifier {
  bool loader = false;
  List<ProductModel> products = [];

  void setProducts(List<ProductModel> products) {
    this.products = products;
    notifyListeners();
  }

  void setLoader(bool loader) {
    this.loader = loader;
    notifyListeners();
  }

  static final _instance = ProductProvider._internal();
  ProductProvider._internal();
  factory ProductProvider() => _instance;
}
