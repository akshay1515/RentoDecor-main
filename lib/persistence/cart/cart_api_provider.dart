import 'dart:convert';

import 'package:eazy_shop/models/cart/cart_server_order.dart';
import 'package:eazy_shop/models/cart/cart_server_response.dart';
import 'package:dio/dio.dart';

class CartApiProvider {
  //This is the London weather API url available at this link: https://openweathermap.org/current
  final String baseUrl_EnquiryApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/insertOrder";
  Future<CartServerResponse> createOrder(CartServerModel model) async {
    Response response = await Dio().post("$baseUrl_EnquiryApi", data: {
      'userId': model.userId,
      'total': model.total,
      'date': model.date,
      'time': model.time,
      'address': model.address,
      'offerId': model.offerId,
      'discountAmt': model.discountAmt,
      'deliveryCharges': model.deliveryCharges,
      'payable': model.payable,
      'text': model.text,
      'items': model.products.map((e) => e.toJson()).toList(),
      'apiVersion': '1.0',
      'token': '',
      'transactionMode': 'online'
    });
    if (response.statusCode == 200) {
      return CartServerResponse.fromJson(
          response.data); //R``eturn decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
