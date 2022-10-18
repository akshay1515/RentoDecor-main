// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpModel _$SendOtpModelFromJson(Map<String, dynamic> json) {
  return SendOtpModel(
    result: json['result'] as String,
    message: json['message'] as String,
    userType: json['userType'] as String ?? 'test',
    data: json['data'] as List,
  );
}

Map<String, dynamic> _$SendOtpModelToJson(SendOtpModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'userType': instance.userType,
      'data': instance.data,
    };
