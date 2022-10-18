import 'package:eazy_shop/models/order/order_list.dart';
import 'package:eazy_shop/models/order/orders_list.dart';
import 'package:eazy_shop/models/order/cancel_order_model.dart';
import 'package:eazy_shop/persistence/order/order_api_provider.dart';

class OrderRepository {
  OrderApiProvider appApiProvider = OrderApiProvider();

  Future<OrdersList> getOrdersByUserId(userId) =>
      appApiProvider.getOrders(userId);
  Future<Orders> getOrderByOrderId(orderId, userId) =>
      appApiProvider.getOrderByOrderId(orderId, userId);
  Future<CancelOrderModel> cancelOrder(orderId, userId, orderStatus) =>
      appApiProvider.cancelOrder(orderId, userId, orderStatus);
}
