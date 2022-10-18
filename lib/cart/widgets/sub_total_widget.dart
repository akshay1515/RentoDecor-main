import 'package:eazy_shop/inherited/cart_container.dart';
import 'package:eazy_shop/inherited/cart_container_state.dart';
import 'package:flutter/material.dart';

class SubTotalWidget extends StatefulWidget {
  SubTotalWidgetState createState() => SubTotalWidgetState();
}

class SubTotalWidgetState extends State<SubTotalWidget> {
  CartContainerState state;
  void didChangeDependencies() {
    super.didChangeDependencies();
    state = CartContainer.of(context);
  }

  Widget build(BuildContext context) {
    state = CartContainer.of(context);
    return Text(
      'Rs. ${state.subTotal.toString()}',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
