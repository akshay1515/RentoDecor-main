// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_server_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartServerResponse _$CartServerResponseFromJson(Map<String, dynamic> json) {
  return CartServerResponse(
    result: json['result'] as String,
    message: json['message'] as String,
    signature: json['signature'] as String,
    txnToken: json['txnToken'] as String,
    orderId: json['orderId'] as String,
  );
}

Map<String, dynamic> _$CartServerResponseToJson(CartServerResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'signature': instance.signature,
      'txnToken': instance.txnToken,
      'orderId': instance.orderId,
    };
