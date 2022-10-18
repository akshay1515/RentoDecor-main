// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    json['productId'] as String,
    json['price'] as String,
    json['qty'] as String,
    json['name'] as String,
    json['catName'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'price': instance.price,
      'qty': instance.qty,
      'name': instance.name,
      'catName': instance.catName,
      'image': instance.image,
    };
