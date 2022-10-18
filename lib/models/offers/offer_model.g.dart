// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) {
  return OfferModel(
    json['id'] as String,
    json['title'] as String,
    json['description'] as String,
    json['image'] as String,
    json['discountPer'] as String,
    json['minBillAmt'] as String,
    json['maxDiscount'] as String,
    json['offerCode'] as String,
    json['userId'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'discountPer': instance.discountPer,
      'minBillAmt': instance.minBillAmt,
      'maxDiscount': instance.maxDiscount,
      'offerCode': instance.offerCode,
      'userId': instance.userId,
      'status': instance.status,
    };
