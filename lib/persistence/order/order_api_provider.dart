import 'dart:convert';
import 'package:eazy_shop/models/order/order_list.dart';
import 'package:eazy_shop/models/order/order_model.dart';
import 'package:eazy_shop/models/order/orders_list.dart';
import 'package:eazy_shop/models/order/cancel_order_model.dart';

import 'package:dio/dio.dart';
import 'package:eazy_shop/models/offers/offers_list.dart';
import 'package:eazy_shop/order/index.dart';

class OrderApiProvider {
  //This is the London weather API url available at this link: https://openweathermap.org/current
  final String baseUrl_OrdersApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/getorderByUserId";

  final String baseUrl_OrdersApi_order_id =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/getorderById";

  final String baseUrl_OrdersApi_cancel_order_id =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/cancelOrder";
  Future<CancelOrderModel> cancelOrder(
      String orderId, String userId, String orderStatus) async {
    Response response = await Dio().post("$baseUrl_OrdersApi_cancel_order_id", data: {
      "userId": userId,
      "orderId": orderId,
      "orderStatus": '5',
      'apiVersion': '1.0',
      'token': ''
    });
    if (response.statusCode == 200) {
      return CancelOrderModel.fromMap(response.data); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<Orders> getOrderByOrderId(String orderId, String userId) async {
    Response response = await Dio().post("$baseUrl_OrdersApi_order_id", data: {
      "userId": userId,
      "id": orderId,
      'apiVersion': '1.0',
      'token': ''
    });
    if (response.statusCode == 200) {
      return Orders.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<OrdersList> getOrders(String userId) async {
    Response response = await Dio().post("$baseUrl_OrdersApi",
        data: {"userId": userId, 'apiVersion': '1.0', 'token': ''});
    if (response.statusCode == 200) {
      return OrdersList.fromJson(response.data); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
