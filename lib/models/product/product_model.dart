import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  String id,
      name,
      categoryId,
      subCategoryId,
      lableId,
      price,
      vendorId,
      qty,
      img1,
      status,
      createdAt,
      description,
      firstname,
      lastname;

  Product(
      this.id,
      this.name,
      this.categoryId,
      this.subCategoryId,
      this.lableId,
      this.price,
      this.vendorId,
      this.qty,
      this.img1,
      this.status,
      this.createdAt,
      this.description,
      this.firstname,
      this.lastname);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
