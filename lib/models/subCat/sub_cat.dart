import 'package:json_annotation/json_annotation.dart';

part 'sub_cat.g.dart';

@JsonSerializable()
class SubCategory {
  String id, subcategoryName, locationtype, catName;
  SubCategory(this.id, this.subcategoryName, this.catName, this.locationtype);

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
