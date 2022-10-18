import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/offers/offers_list.dart';
import 'package:eazy_shop/models/order/orders_list.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/api_provider.dart';
import 'package:eazy_shop/persistence/offers/offer_api_provider.dart';
import 'package:eazy_shop/persistence/order/order_api_provider.dart';
import 'package:eazy_shop/persistence/search/search_api_provider.dart';

class OfferRepository {
  OfferApiProvider appApiProvider = OfferApiProvider();

  Future<Offers> getOffers() => appApiProvider.getOffers();
}
