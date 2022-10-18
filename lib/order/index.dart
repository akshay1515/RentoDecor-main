import 'package:eazy_shop/bloc/order_bloc.dart';
import 'package:eazy_shop/cart/index.dart';
import 'package:eazy_shop/models/order/order_list.dart';
import 'package:eazy_shop/models/order/orders_list.dart';
import 'package:eazy_shop/screens/order_detail/orderdetails.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order extends StatefulWidget {
  OrderState createState() => OrderState();
}

class OrderState extends State<Order> {
  SharedPreferences _preferences;
  String userId = "";
  bool _isLoading = true;
  void initState() {
    super.initState();
    initializePreference();
  }

  initializePreference() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      if (_preferences.containsKey("user")) {
        userId = _preferences.getString("user");
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) orderBloc.getOrdersByUserId(userId);
    return _isLoading
        ? Scaffold(
            body: Center(child: Text("Loading")),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size(
                    double.infinity, MediaQuery.of(context).size.height * 0.08),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
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
                      Text("Order",
                          style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) => CartPage()));
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: StreamBuilder<OrdersList>(
                  stream: orderBloc.orderByUserIdList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.length == 0)
                        return Center(child: Text("No orders Found"));
                      return ListView.builder(
                        itemBuilder: (context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => OrderDetailsPage(
                                          orderId:
                                              snapshot.data.data[index].id)));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.12,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 2.0,
                                        offset: Offset(0.0, 0.75))
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        color: HexColor("#90C416"),
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                    child:
                                        Icon(Icons.home, color: Colors.white),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order ${snapshot.data.data[index].id}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          snapshot.data.data[index].status,
                                          style: TextStyle(
                                              color: snapshot.data.data[index]
                                                          .status ==
                                                      "Submitted"
                                                  ? HexColor("#90C416")
                                                  : Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${snapshot.data.data[index].dateTime}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        padding: const EdgeInsets.all(10.0),
                        itemCount: snapshot.data.data.length,
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error"));
                    }
                    return Center(child: Text("Loading"));
                  }),
            ),
          );
  }
}
