import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/product.dart';

class ProductApi {
  static final collectionRef =
      FirebaseFirestore.instance.collection('products');

  static Future<List<ProductModel>?> getProducts() async {
    final snapshot = await collectionRef.get();
    ProductProvider().setLoader(true);
    try {
      final products = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
      ProductProvider().setProducts(products);
      ProductProvider().setLoader(false);
      return products;
    } catch (e) {
      ProductProvider().setLoader(false);
      print(e);
    }
  }

  static Future<ProductModel?> getProduct(String id) async {
    ProductProvider().setLoader(true);
    try {
      final doc = await collectionRef.doc(id).get();
      ProductProvider().setLoader(false);
      return ProductModel.fromJson(doc.data()!);
    } catch (e) {
      ProductProvider().setLoader(false);
      print(e);
    }
  }

  static Future<bool> addProduct(ProductModel productModel) async {
    ProductProvider().setLoader(true);
    try {
      await collectionRef.add(productModel.toJson());
      ProductProvider().setLoader(false);
      return true;
    } catch (e) {
      ProductProvider().setLoader(false);
      print(e);
      return false;
    }
  }

  static Future<bool> updateProduct(
      {required ProductModel productModel}) async {
    ProductProvider().setLoader(true);
    try {
      await collectionRef.doc(productModel.id).update(productModel.toJson());
      ProductProvider().setLoader(false);
      return true;
    } catch (e) {
      ProductProvider().setLoader(false);
      print(e);
      return false;
    }
  }

  static Future<bool> deleteProduct({required String id}) async {
    ProductProvider().setLoader(true);
    try {
      await collectionRef.doc(id).delete();
      ProductProvider().setLoader(false);
      return true;
    } catch (e) {
      ProductProvider().setLoader(false);
      print(e);
      return false;
    }
  }
}
