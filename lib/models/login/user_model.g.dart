// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['result'] as String,
    json['moveTo'] as String,
    json['message'] as String,
    json['data'] == null
        ? null
        : UserInfoModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'result': instance.result,
      'moveTo': instance.moveTo,
      'message': instance.message,
      'data': instance.data,
    };
