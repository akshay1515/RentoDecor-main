import 'package:eazy_shop/cart/widgets/cart_item.dart';
import 'package:eazy_shop/inherited/cart_container.dart';
import 'package:eazy_shop/inherited/cart_container_state.dart';
import 'package:eazy_shop/models/cart/cart_product_model.dart';
import 'package:flutter/material.dart';

class CartProductsList extends StatefulWidget {
  CartProductsListState createState() => CartProductsListState();
}

class CartProductsListState extends State<CartProductsList> {
  List<CartProductModel> products = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    CartContainerState state = CartContainer.of(context);
    products = state.cartModel.values.toList();
  }

  Widget build(BuildContext context) {
    products = CartContainer.of(context).cartModel.values.toList();
    return products.length == 0
        ? Center(
            child: Text(
              "No Products Found",
              style: TextStyle(color: Colors.black),
            ),
          )
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, int index) {
              return CartItem(product: products[index]);
            },
            padding: const EdgeInsets.all(10.0),
          );
  }
}
