// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiryModel _$EnquiryModelFromJson(Map<String, dynamic> json) {
  return EnquiryModel(
    json['userId'] as String,
    json['userName'] as String,
    json['contact'] as String,
    json['description'] as String,
    json['productId'] as String,
  );
}

Map<String, dynamic> _$EnquiryModelToJson(EnquiryModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'contact': instance.contact,
      'description': instance.description,
      'productId': instance.productId,
    };
