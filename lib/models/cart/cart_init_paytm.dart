import 'package:json_annotation/json_annotation.dart';

part 'cart_init_paytm.g.dart';

@JsonSerializable()
class CartInitPayment {
  CartInitResponse resultInfo;
  String txnToken;

  CartInitPayment(this.resultInfo, this.txnToken);
  factory CartInitPayment.fromJson(Map<String, dynamic> json) =>
      _$CartInitPaymentFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CartInitPaymentToJson(this);
}

@JsonSerializable()
class CartInitResponse {
  String resultStatus;
  String txnToken;

  CartInitResponse(this.resultStatus);
  factory CartInitResponse.fromJson(Map<String, dynamic> json) =>
      _$CartInitResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CartInitResponseToJson(this);
}
