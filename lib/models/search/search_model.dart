import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  String id,
      name,
      subCategoryId,
      categoryId,
      labelId,
      price,
      vendorId,
      qty,
      video,
      img1,
      status,
      createdAt,
      description,
      skuNo,
      material,
      isActive,
      subcatName,
      lableName,
      firstname,
      lastname,
      description2;

  SearchModel(
      this.id,
      this.name,
      this.categoryId,
      this.labelId,
      this.price,
      this.vendorId,
      this.qty,
      this.video,
      this.img1,
      this.status,
      this.createdAt,
      this.description,
      this.skuNo,
      this.material,
      this.subCategoryId,
      this.isActive,
      this.subcatName,
      this.lableName,
      this.firstname,
      this.lastname,
      this.description2);
  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
