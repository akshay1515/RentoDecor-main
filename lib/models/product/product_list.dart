import 'package:eazy_shop/models/cat/cat_model.dart';
import 'package:eazy_shop/models/product/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list.g.dart';

@JsonSerializable()
class Products {
  String result, message;

  List<Product> data;
  Products({this.result, this.message, this.data});
  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
