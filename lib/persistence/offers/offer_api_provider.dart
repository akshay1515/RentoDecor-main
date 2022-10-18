import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eazy_shop/models/offers/offers_list.dart';

class OfferApiProvider {
  //This is the London weather API url available at this link: https://openweathermap.org/current
  final String baseUrl_OffersApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/allOffers";
  Future<Offers> getOffers() async {
    Response response = await Dio().get("$baseUrl_OffersApi");
    if (response.statusCode == 200) {
      return Offers.fromJson(response.data); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
