import 'package:eazy_shop/models/cart/cart_server_response.dart';
import 'package:eazy_shop/persistence/cart/cart_api_provider.dart';

class CartRepository {
  CartApiProvider appApiProvider = CartApiProvider();
//TODO-Start from here
  Future<CartServerResponse> createOrder(model) =>
      appApiProvider.createOrder(model);
}
