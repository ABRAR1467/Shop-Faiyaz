import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/api/auth_api.dart';
import 'package:shop_app/api/product_api.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/orders.dart';

class OrderApi {
  static final collectionRef = FirebaseFirestore.instance.collection('orders');

  static Future<bool> addOrder({required OrderModel orderModel}) async {
    OrderProvider().setLoader(true);
    try {
      final id = collectionRef.doc().id;
      orderModel.id = id;
      orderModel.userId = FirebaseAuth.instance.currentUser!.uid;
      orderModel.createdAt = DateTime.now().toString();
      await collectionRef.doc(id).set(orderModel.toJson());
  
      OrderProvider().setLoader(false);
      return true;
    } catch (e) {
      OrderProvider().setLoader(false);
      print(e);
      return false;
    }
  }

  static Future<List<OrderModel>?> getOrders({String? userId}) async {
    OrderProvider().setLoader(true);
    if(userId==null){
      userId = FirebaseAuth.instance.currentUser!.uid;
    }
    try {
      final snapshot = await collectionRef.where('user_id', isEqualTo: userId).get();
      List<OrderModel> orders = [];
      for (var order in snapshot.docs) {
        final products = <ProductModel>[];
        final productIds = order.data()['products'];

        for (var productId in productIds) {
          final product = await ProductApi.getProduct(productId);
          if (product != null) {
            products.add(product);
          }
        }

        orders.add(OrderModel.fromJson(order.data(), products));
      }
      OrderProvider().setLoader(false);
      OrderProvider().setOrders(orders);
      return orders;
    } catch (e) {
      OrderProvider().setLoader(false);
      print(e);
    }
  }

  static Future<List<OrderModel>?> getOrdersByUserId(String userId) async {
    OrderProvider().setLoader(true);
    try {
      final snapshot =
          await collectionRef.where('user_id', isEqualTo: userId).get();
      List<OrderModel> orders = [];
      for (var order in snapshot.docs) {
        final products = <ProductModel>[];
        final productIds = order.data()['products'];

        for (var productId in productIds) {
          final product = await ProductApi.getProduct(productId);
          if (product != null) {
            products.add(product);
          }
        }
        orders.add(OrderModel.fromJson(order.data(), products));
      }
      OrderProvider().setLoader(false);
      return orders;
    } catch (e) {
      OrderProvider().setLoader(false);
      print(e);
    }
  }

  static Future<bool> updateOrder({required OrderModel orderModel}) async {
    OrderProvider().setLoader(true);
    try {
      await collectionRef.doc(orderModel.id ?? "").update(orderModel.toJson());
      OrderProvider().setLoader(false);
      return true;
    } catch (e) {
      OrderProvider().setLoader(false);
      print(e);
      return false;
    }
  }

  static Future<bool> deleteOrder({required String id}) async {
    OrderProvider().setLoader(true);
    try {
      await collectionRef.doc(id).delete();
      OrderProvider().setLoader(false);
      return true;
    } catch (e) {
      OrderProvider().setLoader(false);
      print(e);
      return false;
    }
  }
}
