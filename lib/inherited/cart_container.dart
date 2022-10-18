import 'package:eazy_shop/inherited/cart_container_state.dart';
import 'package:eazy_shop/inherited/cart_inherited.dart';
import 'package:flutter/material.dart';

class CartContainer extends StatefulWidget {
  final Widget child;
  CartContainer({@required this.child});
  CartContainerState createState() => CartContainerState();

  static CartContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CartInheritedWidget>()
        .state;
  }
}
