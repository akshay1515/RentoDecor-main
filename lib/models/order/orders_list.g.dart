// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) {
  return Orders(
    result: json['result'] as String,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : OrderModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'data': instance.data,
    };
