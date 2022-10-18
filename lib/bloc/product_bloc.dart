import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/product/product_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/product/product_repository.dart';
import 'package:eazy_shop/persistence/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  ProductRepository _repository = ProductRepository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of WeatherResponse object and pass it to the UI screen as a stream.
  final _catFetcher = PublishSubject<Products>();
  Stream<Products> get categories => _catFetcher.stream;

  Future fetchProduct(id) async {
    return await _repository.getProductById(id);
  }

  getProductById(id) async {
    Products weatherResponse = await _repository.getProductById(id);
    _catFetcher.sink.add(weatherResponse);
  }

  dispose() {
    //Close the weather fetcher
    _catFetcher.close();
  }
}

final productBloc = ProductBloc();
