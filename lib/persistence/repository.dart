import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<Categories> getCategories() => appApiProvider.getCategories();
  Future<SubCategories> getSubCategoriesByCategoryId(categoryId) =>
      appApiProvider.getSubCategoriesByCategoryId(categoryId);
}
