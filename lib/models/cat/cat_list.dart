import 'package:eazy_shop/models/cat/cat_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat_list.g.dart';

@JsonSerializable()
class Categories {
  String result, message;

  List<Category> data;
  Categories({this.result, this.message, this.data});
  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}
