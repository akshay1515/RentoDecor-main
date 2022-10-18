import 'package:eazy_shop/bloc/product_bloc.dart';
import 'package:eazy_shop/inherited/cart_container.dart';
import 'package:eazy_shop/inherited/cart_inherited.dart';
import 'package:eazy_shop/models/cart/cart_model.dart';
import 'package:eazy_shop/models/cart/cart_product_model.dart';
import 'package:eazy_shop/models/product/product_list.dart';
import 'package:eazy_shop/services/sqflite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartContainerState extends State<CartContainer> {
  double subTotal = 0.0;
  Map<int, CartProductModel> cartModel = {};
  int count = 0;
  List<CartsModel> rowList = [];
  bool isinit = true;

  bool isLoading = true;
  SharedPreferences _preferences;
  String userId = "";
  void initState() {
    super.initState();
    initializePreference();
  }

  initializePreference() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      if (_preferences.containsKey("user")) {
        userId = _preferences.getString("user");
        _getCartItems();
      }
    });
  }

  Future _getCartItems() async {
    count = await DatabaseHelper.instance
        .getCount(userId != "" ? int.parse(userId) : 1);
    rowList = await DatabaseHelper.instance
        .getcartItems(userId != "" ? int.parse(userId) : 1);
    if (isinit) {
      for (CartsModel element in rowList) {
        Products product = await productBloc.fetchProduct(element.id);
        cartModel.putIfAbsent(
            element.id, () => CartProductModel(product.data[0], element));
      }
      subTotal = calculateSubTotal();
    }
    setState(() {
      isinit = false;
      isLoading = false;
    });
  }

  Future emptyCart() async {
    await DatabaseHelper.instance
        .makeCartEmpty(userId != "" ? int.parse(userId) : 1);
    setState(() {
      cartModel = {};
    });
  }

  Future removeItemFromCart(int productId) async {
    updateCartPricing(productId, 0);
  }

  Future updateCartPricing(int productId, int quantity) async {
    await DatabaseHelper.instance.deleteCartItem({
      DatabaseHelper.product_id: productId,
      DatabaseHelper.cart_id: int.parse(userId)
    });
    setState(() {
      CartsModel model = cartModel[productId].model;
      model.quantity = quantity;
      if (quantity == 0) cartModel.remove(productId);

      subTotal = calculateSubTotal();
    });
  }

  double calculateSubTotal() {
    List<CartProductModel> products = cartModel.values.toList();
    double totalCost = 0.0;
    for (int i = 0; i < products.length; i++) {
      double total = double.parse(products[i].product.price);
      int qty = products[i].model.quantity;
      double productCost = total * qty;
      totalCost += productCost;
    }
    return totalCost;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Text("Loading"))
        : CartInheritedWidget(state: this, child: widget.child);
  }
}
