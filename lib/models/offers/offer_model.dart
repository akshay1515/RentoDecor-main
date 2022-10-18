import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  String id,
      title,
      description,
      image,
      discountPer,
      minBillAmt,
      maxDiscount,
      offerCode,
      userId,
      status;

  OfferModel(
      this.id,
      this.title,
      this.description,
      this.image,
      this.discountPer,
      this.minBillAmt,
      this.maxDiscount,
      this.offerCode,
      this.userId,
      this.status);

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);
  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
