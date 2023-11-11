import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid({super.key, required this.showFavs});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: ((context, productProvider, child) {
        print("productProvider.products.length ${productProvider.products.length}");
        List<ProductModel> _products = [];
        if (showFavs) {
          _products = productProvider.products.where((element) => element.isFavorite).toList();
        } else {
          _products = productProvider.products;
        }
        return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _products.length ?? 0,
          itemBuilder: (context, index) {

            return ProductItem(
              product: _products[index],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      }),
    );
  }
}
