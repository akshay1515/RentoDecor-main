import 'package:eazy_shop/cart/widgets/cart_products_list.dart';
import 'package:eazy_shop/cart/widgets/sub_total_widget.dart';
import 'package:eazy_shop/cart_address/index.dart';
import 'package:eazy_shop/inherited/cart_container.dart';
import 'package:eazy_shop/inherited/cart_container_state.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: CartContainer(
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomWidget(),
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size(
                  double.infinity, MediaQuery.of(context).size.height * 0.08),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor("#2EB2F2"), HexColor("#2361AE")],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.navigate_before,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text("Cart",
                        style: GoogleFonts.montserrat(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    Expanded(child: SizedBox()),
                    RemoveIconWidget(),
                  ],
                ),
              ),
            ),
            body: CartProductsList(),
          ),
        ),
      ),
    );
  }
}

class RemoveIconWidget extends StatefulWidget {
  RemoveIconWidgetState createState() => RemoveIconWidgetState();
}

class RemoveIconWidgetState extends State<RemoveIconWidget> {
  CartContainerState state;

  void didChangeDependencies() {
    super.didChangeDependencies();
    state = CartContainer.of(context);
  }

  Widget build(BuildContext context) {
    return state.cartModel.length > 0
        ? IconButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              state.emptyCart();
            },
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.white,
            ),
          )
        : Container();
  }
}

class BottomWidget extends StatefulWidget {
  BottomWidget({
    Key key,
  }) : super(key: key);

  BottomWidgetState createState() => BottomWidgetState();
}

class BottomWidgetState extends State<BottomWidget> {
  CartContainerState state;

  void didChangeDependencies() {
    super.didChangeDependencies();
    state = CartContainer.of(context);
  }

  @override
  Widget build(BuildContext context) {
    state = CartContainer.of(context);
    return state.cartModel.length > 0
        ? Container(
            margin: const EdgeInsets.all(10.0),
            padding:
                const EdgeInsets.only(left: 10.0,right:10 ,bottom:10,top: 10.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.075,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [HexColor("#0E96D9"), HexColor("#2273BB")])),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => CartAddressPage(
                              cartModel: state.cartModel,
                            )));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                          child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Total Cost",
                            style: TextStyle(color: Colors.white),
                          ),
                          SubTotalWidget()
                        ],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Row(
                        children: [
                          Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.black,

                          ),
                        ],
                      ))
                ],
              ),
            ),
          )
        : Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_rounded,color: Colors.black38,size: 100,),
          SizedBox(height: 10,),
          Text('Your cart is empty',style: TextStyle(color: Colors.black38),)
        ],
      ),
    );
  }
}
