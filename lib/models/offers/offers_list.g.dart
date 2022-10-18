// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offers _$OffersFromJson(Map<String, dynamic> json) {
  return Offers(
    result: json['result'] as String,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : OfferModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'data': instance.data,
    };
