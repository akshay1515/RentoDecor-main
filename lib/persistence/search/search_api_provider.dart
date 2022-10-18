import 'dart:convert';

import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:http/http.dart';

class SearchApiProvider {
  Client client = Client();

  //This is the London weather API url available at this link: https://openweathermap.org/current
  final String baseUrl_CatApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/getProductsByCategoryId";
  final String baseUrl_SubCatApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/getProductsBySubCategoryId";
  final String baseUrl_SearchApi =
      "http://yontechsoftwares.com/share/swastik/index.php/Api/search/";
  Future<SearchList> searchKeyword(String keyword) async {
    final response = await client.get(Uri.parse('${baseUrl_SearchApi}${keyword}')); // Make the network call asynchronously to fetch the London weather data.

    if (response.statusCode == 200) {
      return SearchList.fromJson(
          jsonDecode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<SearchList> getSearchList(String id, bool isSubCategory) async {
    final String api = isSubCategory ? baseUrl_SubCatApi : baseUrl_CatApi;
    final response = await client.post(Uri.parse(api),
        body: jsonEncode(<String, String>{
          "id": id,
          'apiVersion': '1.0',
          'token': ''
        })); // Make the network call asynchronously to fetch the London weather data.

    if (response.statusCode == 200) {
      return SearchList.fromJson(
          jsonDecode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
