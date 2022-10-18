import 'package:eazy_shop/models/order/order_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../order/index.dart';

part 'orders_list.g.dart';

@JsonSerializable()
class Orders {
  String result, message;

  OrderModel data;
  Orders({this.result, this.message, this.data});
  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
