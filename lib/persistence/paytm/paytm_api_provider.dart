import 'dart:convert';

import 'package:eazy_shop/models/cart/cart_init_paytm.dart';
import 'package:eazy_shop/models/cart/cart_server_order.dart';
import 'package:eazy_shop/models/cart/cart_server_response.dart';
import 'package:http/http.dart';
import 'package:paytm/paytm.dart';

class PaytmProvider {
  //This is the London weather API url available at this link: https://openweathermap.org/current
  Future<Map<dynamic, dynamic>> callPaytm(
      CartServerModel model, CartServerResponse token) async {
    String callBackUrl =
        'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=' +
            token.orderId.toString();
    Map<dynamic, dynamic> paytmResponse = await Paytm.payWithPaytm(
        'KFeNVY73210953511442',
        token.orderId.toString(),
        token.txnToken,
        model.discountAmt.toString(),
        "",
        false);
    return paytmResponse;
  }
/*
  Future<CartInitResponse> initiateTransactionWithPaytm(
      CartServerModel model, CartServerResponse checkSum) async {
    String url =
        'https://securegw.paytm.in/theia/api/v1/initiateTransaction?mid=KFeNVY73210953511442&orderId=' +
            checkSum.orderId.toString();
    Client client = Client();
    final response = await client.post(url,
        headers: <String, String>{'signature': checkSum.checksum},
        body: jsonEncode(<String, dynamic>{
          "requestType": "Payment",
          "mid": "KFeNVY73210953511442",
          "websiteName": "DEFAULT",
          "orderId": checkSum.orderId.toString(),
          "callbackUrl": "https://merchant.com/callback",
          "txnAmount": {
            "value": model.discountAmt.toString(),
            "currency": "INR",
          },
        })); // Make the network call asynchronously to fetch the London weather data.

    if (response.statusCode == 200) {
      return CartInitResponse.fromJson(
          jsonDecode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }*/
}
