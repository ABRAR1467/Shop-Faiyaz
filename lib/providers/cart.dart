import "package:flutter/material.dart";
import "package:shop_app/models/product_model.dart";

class CartProvider extends ChangeNotifier {
 List<ProductModel> products = [];

  void addProduct(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    products.remove(product);
    notifyListeners();
  }

  void clearCart() {
    products.clear();
    notifyListeners();
  }

  static final _instance = CartProvider._internal();
  CartProvider._internal();
  factory CartProvider() => _instance;
}
