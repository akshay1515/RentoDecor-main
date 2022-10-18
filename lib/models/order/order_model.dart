import 'package:json_annotation/json_annotation.dart';
import './item_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id, orderAmount, status, dateTime, fname, lname, pname, total;
  List<OrderItem> items;
  OrderModel(this.id, this.orderAmount, this.status, this.dateTime, this.fname,
      this.pname, this.lname, this.total, this.items);

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
