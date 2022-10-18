// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) {
  return SearchModel(
    json['id'] as String,
    json['name'] as String,
    json['categoryId'] as String,
    json['labelId'] as String,
    json['price'] as String,
    json['vendorId'] as String,
    json['qty'] as String,
    json['video'] as String,
    json['img1'] as String,
    json['status'] as String,
    json['createdAt'] as String,
    json['description'] as String,
    json['skuNo'] as String,
    json['material'] as String,
    json['subCategoryId'] as String,
    json['isActive'] as String,
    json['subcatName'] as String,
    json['lableName'] as String,
    json['firstname'] as String,
    json['lastname'] as String,
    json['description2'] as String,
  );
}

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subCategoryId': instance.subCategoryId,
      'categoryId': instance.categoryId,
      'labelId': instance.labelId,
      'price': instance.price,
      'vendorId': instance.vendorId,
      'qty': instance.qty,
      'video': instance.video,
      'img1': instance.img1,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'description': instance.description,
      'skuNo': instance.skuNo,
      'material': instance.material,
      'isActive': instance.isActive,
      'subcatName': instance.subcatName,
      'lableName': instance.lableName,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'description2': instance.description2,
    };
