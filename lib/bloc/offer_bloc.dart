import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/offers/offers_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/offers/offer_repository.dart';
import 'package:eazy_shop/persistence/repository.dart';
import 'package:rxdart/rxdart.dart';

class OfferBloc {
  OfferRepository _repository = OfferRepository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of WeatherResponse object and pass it to the UI screen as a stream.
  final _catFetcher = PublishSubject<Offers>();
  Stream<Offers> get categories => _catFetcher.stream;

  getOffers() async {
    Offers weatherResponse = await _repository.getOffers();
    _catFetcher.sink.add(weatherResponse);
  }

  dispose() {
    //Close the weather fetcher
    _catFetcher.close();
  }
}

final offerBloc = OfferBloc();
