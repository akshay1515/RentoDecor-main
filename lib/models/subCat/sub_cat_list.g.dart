// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_cat_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategories _$SubCategoriesFromJson(Map<String, dynamic> json) {
  return SubCategories(
    result: json['result'] as String,
    message: json['message'] as String,
    subcategories: (json['subcategories'] as List)
        ?.map((e) =>
            e == null ? null : SubCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubCategoriesToJson(SubCategories instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'subcategories': instance.subcategories,
    };
