// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    json['id'] as String,
    json['orderAmount'] as String,
    json['status'] as String,
    json['dateTime'] as String,
    json['fname'] as String,
    json['pname'] as String,
    json['lname'] as String,
    json['total'] as String,
    (json['items'] as List)
        ?.map((e) =>
            e == null ? null : OrderItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderAmount': instance.orderAmount,
      'status': instance.status,
      'dateTime': instance.dateTime,
      'fname': instance.fname,
      'lname': instance.lname,
      'pname': instance.pname,
      'total': instance.total,
      'items': instance.items,
    };
