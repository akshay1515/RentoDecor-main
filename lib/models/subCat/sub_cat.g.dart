// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) {
  return SubCategory(
    json['id'] as String,
    json['subcategoryName'] as String,
    json['catName'] as String,
    json['locationtype'] as String,
  );
}

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subcategoryName': instance.subcategoryName,
      'locationtype': instance.locationtype,
      'catName': instance.catName,
    };
