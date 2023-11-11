import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = "product detail";

  const ProductDetail({Key? key,required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product?.name??"[n/a]",
                style: const TextStyle(color: Colors.black),
              ),
              background: Hero(
                tag: product.id??"[n/a]",
                child: Image.network(product.image??"", fit: BoxFit.cover),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Text(
                    product.price?.toString()??"0",
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    product.description??"",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 800),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
