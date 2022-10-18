import 'dart:convert';

import 'package:eazy_shop/models/product/product_list.dart';
import 'package:dio/dio.dart';

class ProductApiProvider {
  //This is the London weather API url available at this link: https://openweathermap.org/current
  final String baseUrl_OffersApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/getProductById";
  Future<Products> getProductById(id) async {
    Response response = await Dio().post("$baseUrl_OffersApi",
        data: {'id': id, 'token': '', 'apiVersion': '1.0'});
    if (response.statusCode == 200) {
      return Products.fromJson(response.data); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
