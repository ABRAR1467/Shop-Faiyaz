import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/api/product_api.dart';
import 'package:shop_app/models/product_model.dart';

import '../providers/product.dart';

// ignore: must_be_immutable
class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  ProductModel? product;

  EditProductScreen({Key? key,  this.product}) : super(key: key);

  @override
  EditProductScreenState createState() => EditProductScreenState();
}

class EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product?.name ?? "";
      priceController.text = widget.product?.price?.toString()??"0";
      descriptionController.text = widget.product?.description ?? "";
      imageUrlController.text = widget.product?.image ?? "";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();

    super.dispose();
  }

  void _updateImageUrl() {
    if (!imageUrlController.text.startsWith('http') &&
        !imageUrlController.text.startsWith('https')) {
      return;
    }
    if (!imageUrlController.text.endsWith('.png') &&
        !imageUrlController.text.endsWith('.jpg') &&
        !imageUrlController.text.endsWith('.jpeg')) {
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    if (widget.product== null) {
      // add product
      bool? res = await ProductApi.addProduct(
          productModel: ProductModel(
        name: nameController.text,
        price: double.parse(priceController.text),
        description: descriptionController.text,
        image: imageUrlController.text,
        isFavorite: false,
        quantity: 1,
      ));
      if (res != null && res) {
        Navigator.of(context).pop();
      }
      return;
    } else {
      widget.product?.name = nameController.text;
      widget.product?.price = double.parse(priceController.text);
      widget.product?.description = descriptionController.text;
      widget.product?.image = imageUrlController.text;
      // update product
      bool? res = await ProductApi.updateProduct(productModel: widget.product!);
      if (res != null && res) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body:
          Consumer<ProductProvider>(builder: (context, productProvider, child) {
        if (productProvider.loader) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a price.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than zero.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description.';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long.';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: imageUrlController.text.isEmpty
                          ? const Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: imageUrlController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an image URL.';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL.';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image URL.';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
