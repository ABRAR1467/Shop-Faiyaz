import "package:flutter/material.dart";
import "package:shop_app/models/cart_model.dart";
import "package:shop_app/models/product_model.dart";

class CartProvider extends ChangeNotifier {

  List<CartModel> cartsItems = [];

  void addProduct(ProductModel product) {
    final index = cartsItems.indexWhere((element) => element.product.id == product.id);
    if(index>=0){
      cartsItems[index].quantity++;
    }else{
      cartsItems.add(CartModel(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    final index = cartsItems.indexWhere((element) => element.product.id == product.id);
    if(index>=0){
      if(cartsItems[index].quantity>1){
        cartsItems[index].quantity--;
      }else{
        cartsItems.removeAt(index);
      }
    }
    notifyListeners();
  }

  void clearCart() {
  cartsItems.clear();
    notifyListeners();
  }

  static final _instance = CartProvider._internal();
  CartProvider._internal();
  factory CartProvider() => _instance;
}
