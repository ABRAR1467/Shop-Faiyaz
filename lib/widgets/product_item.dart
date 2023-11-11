import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shop_app/api/product_api.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/product_detail.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  GestureDetector imageToItsDetails(
      BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetail.routeName,
          arguments: product.id,
        );
      },
      child: Hero(
        tag: product.id!,
        child: FadeInImage(
          placeholder: const AssetImage("assets/images/placeholder.png"),
          image: NetworkImage(
            product.image ?? "",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // whole build will run when something changes, consumer way when some sub part runs again

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            product.name ?? "[n/a]",
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            color: Colors.red,
            onPressed: () {
              product.isFavorite = !product.isFavorite;
              ProductApi.updateProduct(productModel: product);
            },
            icon: Icon(
              product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
            ),
          ),
          trailing: Row(
            children: [
              IconButton(
                color: Colors.red,
                onPressed: () {
                  CartProvider().addProduct(product);

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added ${product.name ?? ""} to Cart"),
                      duration: const Duration(milliseconds: 1400),
                      action: SnackBarAction(
                        label: "Undo ",
                        onPressed: () {
                          CartProvider().removeProduct(product);
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (FirebaseAuth.instance.currentUser?.uid != null &&
                  FirebaseAuth.instance.currentUser!.uid ==
                      "XooIzEuF6zQqgyq9WBGcimr5xiZ2")
                IconButton(
                    onPressed: () {
                      ProductApi.deleteProduct(id: product.id!);
                    },
                    icon: Icon(Icons.delete))
            ],
          ),
        ),
        child: InkWell(
            onTap: () {
              // if (FirebaseAuth.instance.currentUser?.uid != null &&
              //     FirebaseAuth.instance.currentUser!.uid ==
              //         "XooIzEuF6zQqgyq9WBGcimr5xiZ2") {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       settings: RouteSettings(
              //           name: EditProductScreen.routeName, arguments: product),
              //       builder: (context) => EditProductScreen(product: product)));
              // }
            },
            child: imageToItsDetails(context, product)),
      ),
    );
  }
}
