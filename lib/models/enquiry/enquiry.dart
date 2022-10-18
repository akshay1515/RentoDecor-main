import 'package:json_annotation/json_annotation.dart';
part 'enquiry.g.dart';

@JsonSerializable()
class EnquiryModel {
  String userId, userName, contact, description, productId;

  EnquiryModel(this.userId, this.userName, this.contact, this.description,
      this.productId);
  factory EnquiryModel.fromJson(Map<String, dynamic> json) =>
      _$EnquiryModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EnquiryModelToJson(this);
}
