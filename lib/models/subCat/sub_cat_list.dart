import 'package:eazy_shop/models/subCat/sub_cat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_cat_list.g.dart';

@JsonSerializable()
class SubCategories {
  String result, message;

  List<SubCategory> subcategories;
  SubCategories({this.result, this.message, this.subcategories});
  factory SubCategories.fromJson(Map<String, dynamic> json) =>
      _$SubCategoriesFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SubCategoriesToJson(this);
}
