import 'package:eazy_shop/models/order/order_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../order/index.dart';

part 'order_list.g.dart';

@JsonSerializable()
class OrdersList {
  String result, message;

  List<OrderModel> data;
  OrdersList({this.result, this.message, this.data});
  factory OrdersList.fromJson(Map<String, dynamic> json) =>
      _$OrdersListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OrdersListToJson(this);
}
