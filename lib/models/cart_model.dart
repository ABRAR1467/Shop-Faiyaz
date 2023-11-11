import 'package:shop_app/models/product_model.dart';

class CartModel{
  ProductModel product;
  int quantity=1;

  CartModel({required this.product, required this.quantity});

}