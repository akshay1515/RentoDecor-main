import 'package:eazy_shop/models/cart/cart_model.dart';
import 'package:eazy_shop/models/product/product_model.dart';

class CartProductModel {
  Product product;
  CartsModel model;

  CartProductModel(this.product, this.model);
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (model.id != null) {
      map['id'] = model.id;
    }
    map['model'] = model;
    map['product'] = product;
    return map;
  }
}
