// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchList _$SearchListFromJson(Map<String, dynamic> json) {
  return SearchList(
    result: json['result'] as String,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SearchModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchListToJson(SearchList instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'data': instance.data,
    };
