// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'] as String,
    json['name'] as String,
    json['categoryId'] as String,
    json['subCategoryId'] as String,
    json['lableId'] as String,
    json['price'] as String,
    json['vendorId'] as String,
    json['qty'] as String,
    json['img1'] as String,
    json['status'] as String,
    json['createdAt'] as String,
    json['description'] as String,
    json['firstname'] as String,
    json['lastname'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
      'lableId': instance.lableId,
      'price': instance.price,
      'vendorId': instance.vendorId,
      'qty': instance.qty,
      'img1': instance.img1,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'description': instance.description,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
