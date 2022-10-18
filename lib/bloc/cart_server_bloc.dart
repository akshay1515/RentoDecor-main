
import 'package:eazy_shop/models/cart/cart_server_order.dart';
import 'package:eazy_shop/models/cart/cart_server_response.dart';

import 'package:eazy_shop/persistence/cart/cart_repository.dart';
import 'package:eazy_shop/persistence/paytm/paytm_repository.dart';

class CartServerBloc {
  CartRepository _repository = CartRepository();
  PaytmRepository _paytmRepository = PaytmRepository();
  Future<CartServerResponse> createOrder(CartServerModel model) async {
    CartServerResponse checkSum = await _repository.createOrder(model);
    return checkSum;
  }

  Future<Map<dynamic, dynamic>> callPaytm(
      CartServerModel model, CartServerResponse checkSum) async {
    return await _paytmRepository.callPaytm(model, checkSum);
  }
}

final cartServerBloc = CartServerBloc();
