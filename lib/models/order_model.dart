import 'package:shop_app/models/product_model.dart';

class OrderModel{
  String? id;
  String? total;
  String? status;
  String? userId;
  List<ProductModel>? products=[];
  String? createdAt;
  String? updatedAt;

  OrderModel({
    this.id,
    this.products,
    this.total,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt
  });

  OrderModel.fromJson(Map<String, dynamic> json,List<ProductModel> products){
    id = json['id'];
    this.products = products;
    total = json['total'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'total': total,
      'status': status,
      'user_id': userId,
      'products': products?.map((e) => e.id).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }
}