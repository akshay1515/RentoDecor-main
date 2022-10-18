// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_init_paytm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartInitPayment _$CartInitPaymentFromJson(Map<String, dynamic> json) {
  return CartInitPayment(
    json['resultInfo'] == null
        ? null
        : CartInitResponse.fromJson(json['resultInfo'] as Map<String, dynamic>),
    json['txnToken'] as String,
  );
}

Map<String, dynamic> _$CartInitPaymentToJson(CartInitPayment instance) =>
    <String, dynamic>{
      'resultInfo': instance.resultInfo,
      'txnToken': instance.txnToken,
    };

CartInitResponse _$CartInitResponseFromJson(Map<String, dynamic> json) {
  return CartInitResponse(
    json['resultStatus'] as String,
  )..txnToken = json['txnToken'] as String;
}

Map<String, dynamic> _$CartInitResponseToJson(CartInitResponse instance) =>
    <String, dynamic>{
      'resultStatus': instance.resultStatus,
      'txnToken': instance.txnToken,
    };
