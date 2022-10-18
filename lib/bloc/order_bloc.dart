import 'package:eazy_shop/models/order/order_list.dart';
import 'package:eazy_shop/models/order/orders_list.dart';
import 'package:eazy_shop/models/order/cancel_order_model.dart';
import 'package:eazy_shop/persistence/order/order_repository.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc {
  OrderRepository _repository = OrderRepository();

  final _orderByUserIdFetcher = PublishSubject<OrdersList>();
  Stream<OrdersList> get orderByUserIdList => _orderByUserIdFetcher.stream;

  final _orderByOrderIdFetcher = PublishSubject<Orders>();
  Stream<Orders> get orderByOrderId => _orderByOrderIdFetcher.stream;

  getOrdersByUserId(String userId) async {
    OrdersList weatherResponse = await _repository.getOrdersByUserId(userId);
    _orderByUserIdFetcher.sink.add(weatherResponse);
  }

  getOrdersByOrderId(String orderId, String userId) async {
    Orders weatherResponse =
        await _repository.getOrderByOrderId(orderId, userId);
    _orderByOrderIdFetcher.sink.add(weatherResponse);
  }

  Future<CancelOrderModel> cancelOrder(
      String orderId, String userId, String orderStatus) async {
    return _repository.cancelOrder(orderId, userId, orderStatus);
  }

  dispose() {
    _orderByUserIdFetcher.close();
    _orderByOrderIdFetcher.close();
  }
}

final orderBloc = OrderBloc();
