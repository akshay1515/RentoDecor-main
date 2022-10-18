import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/api_provider.dart';
import 'package:eazy_shop/persistence/search/search_api_provider.dart';

class SearchRepository {
  SearchApiProvider appApiProvider = SearchApiProvider();

  Future<SearchList> getProductsByCategoryId(id, isSubCategory) =>
      appApiProvider.getSearchList(id, isSubCategory);

  Future<SearchList> getProductsBySubCategoryId(id, isSubCategory) =>
      appApiProvider.getSearchList(id, isSubCategory);

  Future<SearchList> getProductsByKeyword(keyword) =>
      appApiProvider.searchKeyword(keyword);
}
