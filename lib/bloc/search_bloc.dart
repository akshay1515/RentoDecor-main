import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/repository.dart';
import 'package:eazy_shop/persistence/search/search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  SearchRepository _repository = SearchRepository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of WeatherResponse object and pass it to the UI screen as a stream.
  final _searchFetcher = PublishSubject<SearchList>();
  Stream<SearchList> get searchList => _searchFetcher.stream;

  getProductsByCategoryId(String catId, bool isSubCategory) async {
    SearchList weatherResponse =
        await _repository.getProductsByCategoryId(catId, isSubCategory);
    _searchFetcher.sink.add(weatherResponse);
  }

  Future<SearchList> getProductsBySearchKeyword(String keyword) async {
    SearchList weatherResponse =
        await _repository.getProductsByKeyword(keyword);
    return weatherResponse;
  }

  getProductsBySubCategoryId(String catId, bool isSubCategory) async {
    SearchList weatherResponse =
        await _repository.getProductsBySubCategoryId(catId, isSubCategory);
    _searchFetcher.sink.add(weatherResponse);
  }

  dispose() {
    //Close the weather fetcher
    _searchFetcher.close();
  }
}

final searchBloc = SearchBloc();
