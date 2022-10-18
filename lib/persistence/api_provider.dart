import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';

class ApiProvider {
  //This is the London weather API url available at this link: https://openweathermap.org/current
  final _baseUrl_CategoriesApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/allCategories";

  final _baseUrl_SubCategoriesApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/getSubCategoryByCategoryId";

  Future<Categories> getCategories() async {
    try {
      Response response = await Dio().get("$_baseUrl_CategoriesApi");
      if (response.statusCode == 200) {
        Categories categories = Categories.fromJson(response.data);
        return categories; //Return decoded response
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    /*final response = await client.get(
        "$_baseUrl_CategoriesApi"); // Make the network call asynchronously to fetch the London weather data.

    if (response.statusCode == 200) {
      return Categories.fromJson(
          jsonDecode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }*/
  }

  Future<SubCategories> getSubCategoriesByCategoryId(String categoryId) async {
    Response response = await Dio().post("$_baseUrl_SubCategoriesApi",
        data: {"id": categoryId, "apiVersion": "1.0", "token": ""});
    if (response.statusCode == 200) {
      return SubCategories.fromJson(response.data); //Return decoded response
    } else {
      throw Exception('Failed to load Sub categories');
    }
  }
}
