// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['id'] as String,
    json['categoryName'] as String,
    json['type'] as String,
    json['status'] as String,
    json['isDeleted'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'type': instance.type,
      'status': instance.status,
      'isDeleted': instance.isDeleted,
      'image': instance.image,
    };
