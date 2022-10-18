import 'dart:convert';

import 'package:eazy_shop/models/enquiry/enquiry.dart';
import 'package:http/http.dart';

class EnquiryApiProvider {
  Client client = Client();

  //This is the London weather API url available at this link: https://openweathermap.org/current
  final String baseUrl_EnquiryApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/enquiry";
  Future<bool> createQuery(EnquiryModel model) async {
    final response = await client.post(Uri.parse(baseUrl_EnquiryApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': int.parse(model.userId),
          'userName': model.userName,
          'contact': model.contact,
          'productId': model.productId,
          'text': model.description,
          'apiVersion': '1.0'
        })); // Make the network call asynchronously to fetch the London weather data.

    if (response.statusCode == 200) {
      return true; //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
