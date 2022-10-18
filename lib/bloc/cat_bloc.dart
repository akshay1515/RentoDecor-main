import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  Repository _repository = Repository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of WeatherResponse object and pass it to the UI screen as a stream.
  final _catFetcher = PublishSubject<Categories>();
  final _subCatFetcher = PublishSubject<SubCategories>();

  //This method is used to pass the weather response as stream to UI
  Stream<Categories> get categories => _catFetcher.stream;
  Stream<SubCategories> get subCategories => _subCatFetcher.stream;

  getCategories() async {
    Categories weatherResponse = await _repository.getCategories();
    _catFetcher.sink.add(weatherResponse);
  }

  Future<List<SubCategory>> getSubCategoriesByCategoryId(
      String categoryId) async {
    SubCategories subCatResponse =
        await _repository.getSubCategoriesByCategoryId(categoryId);
    _subCatFetcher.sink.add(subCatResponse);
    return subCatResponse.subcategories;
  }

  dispose() {
    //Close the weather fetcher
    _catFetcher.close();
    _subCatFetcher.close();
  }
}

final catBloc = CategoryBloc();
