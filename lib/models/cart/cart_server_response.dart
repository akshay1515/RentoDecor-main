import 'package:json_annotation/json_annotation.dart';
part 'cart_server_response.g.dart';

@JsonSerializable()
class CartServerResponse {
  String result, message, signature, txnToken;
  String orderId;
  CartServerResponse(
      {this.result, this.message, this.signature, this.txnToken, this.orderId});
  factory CartServerResponse.fromJson(Map<String, dynamic> json) =>
      _$CartServerResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CartServerResponseToJson(this);
}
