import 'package:json_annotation/json_annotation.dart';
part 'send_otp.g.dart';

@JsonSerializable()
class SendOtpModel {
  String result, message;

  @JsonKey(defaultValue: "test")
  String userType;
  List<dynamic> data;
  SendOtpModel({this.result, this.message, this.userType, this.data});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SendOtpModel.fromJson(Map<String, dynamic> json) =>
      _$SendOtpModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SendOtpModelToJson(this);

  /*factory SendOtpModel.fromJson(Map<String, dynamic> json) {
    return SendOtpModel(
        data: List.from(json["data"]),
        result: json["result"],
        message: json["message"],
        userType: json["userType"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "result": result,
      "message": message,
      "userType": userType,
      "data": data
    };
  }*/
}
