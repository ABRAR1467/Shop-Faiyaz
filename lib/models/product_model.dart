class ProductModel{
  String?id;
  String? name;
  String? description;
  String? image;
  num? price;
  int? quantity;
  bool isFavorite = false;

  ProductModel({this.name, this.description, this.image, this.price, this.quantity,this.isFavorite=false, this.id});

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] =description;
    data['image'] = image;
    data['price'] = price;
    data['quantity'] = quantity;
    data['is_favorite'] = isFavorite;
    return data;
  }
}