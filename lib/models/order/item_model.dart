import 'package:json_annotation/json_annotation.dart';
part 'item_model.g.dart';

@JsonSerializable()
class OrderItem {
  String productId, price, qty, name, catName, image;

  OrderItem(this.productId, this.price, this.qty, this.name, this.catName,
      this.image);
  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
