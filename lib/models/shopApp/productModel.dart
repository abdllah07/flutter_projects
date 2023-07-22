class ProductModel {
  bool? status;
  ProductDataModel? data;

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ProductDataModel.fromJson(json['data']);
  }
}

class ProductDataModel {
  List<bannerModel> banners = [];
  List<productModel> products = [];

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(bannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(productModel.fromJson(element));
    });
  }
}

class bannerModel {
  int? id;
  String? image;

  bannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class productModel {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  late String image;
  late String name;
  bool? in_favorites;
  bool? in_cart;

  productModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    image = json['image'];
  }
}
