import 'package:eazy_shop/models/cart/cart_init_paytm.dart';
import 'package:eazy_shop/models/cart/cart_server_order.dart';
import 'package:eazy_shop/models/cart/cart_server_response.dart';
import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/offers/offers_list.dart';
import 'package:eazy_shop/models/order/orders_list.dart';
import 'package:eazy_shop/models/search/search_model_list.dart';
import 'package:eazy_shop/models/subCat/sub_cat_list.dart';
import 'package:eazy_shop/persistence/api_provider.dart';
import 'package:eazy_shop/persistence/cart/cart_api_provider.dart';
import 'package:eazy_shop/persistence/enquiry/enquiry_api_provider.dart';
import 'package:eazy_shop/persistence/offers/offer_api_provider.dart';
import 'package:eazy_shop/persistence/order/order_api_provider.dart';
import 'package:eazy_shop/persistence/paytm/paytm_api_provider.dart';
import 'package:eazy_shop/persistence/search/search_api_provider.dart';

class PaytmRepository {
  PaytmProvider appApiProvider = PaytmProvider();
//TODO-Start from here
  Future<Map<dynamic, dynamic>> callPaytm(
          CartServerModel model, CartServerResponse checkSum) =>
      appApiProvider.callPaytm(model, checkSum);
}
