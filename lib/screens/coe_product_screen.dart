import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';

class COEProductSCreen extends StatefulWidget {
  static const routeName = "/coe-product-screen";
  ProductModel? product;
  COEProductSCreen({super.key, this.product});

  @override
  State<COEProductSCreen> createState() => _COEProductSCreenState();
}

class _COEProductSCreenState extends State<COEProductSCreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.product?.name ?? "no product");
    if (widget.product != null) {
      nameController.text = widget.product?.name ?? "";
      priceController.text = widget.product?.price?.toString() ?? "0";
      descriptionController.text = widget.product?.description ?? "";
      imageUrlController.text = widget.product?.image ?? "";
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
