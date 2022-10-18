import 'package:eazy_shop/models/cat/cat_model.dart';
import 'package:eazy_shop/models/offers/offer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offers_list.g.dart';

@JsonSerializable()
class Offers {
  String result, message;

  List<OfferModel> data;
  Offers({this.result, this.message, this.data});
  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OffersToJson(this);
}
