import 'package:eazy_shop/models/order/item_model.dart';
import 'package:eazy_shop/models/order/order_list.dart';
import 'package:eazy_shop/screens/cancel_order_screen.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eazy_shop/bloc/order_bloc.dart';
import 'package:eazy_shop/models/order/orders_list.dart';
import 'package:eazy_shop/models/order/order_model.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:eazy_shop/widgets/progress_bar.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;
  OrderDetailsPage({this.orderId});
  OrderDetailsPageState createState() => OrderDetailsPageState();
}

class OrderDetailsPageState extends State<OrderDetailsPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  SharedPreferences _preferences;
  ProgressDialog progressDialog;
  String userId = "";
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    initializePreference();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
    progressDialog = createProgressDialogObject(context);
    styleProgressDialog(progressDialog, 'Cancelling Order');
    if (!_isLoading) orderBloc.getOrdersByOrderId(widget.orderId, userId);
    return _isLoading
        ? Scaffold(
            body: Center(child: Text("Loading")),
          )
        : SafeArea(
            top: true,
            child: Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: PreferredSize(
                preferredSize: Size(
                    double.infinity, MediaQuery.of(context).size.height),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10.0,right:20.0, bottom: 10.0,top: 10),
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
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                      Spacer(),
                      Text("Order Id : ${widget.orderId}",
                          style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      Container(width: 40,height: MediaQuery.of(context).size.height*0.06,),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              body: StreamBuilder<Orders>(
                  stream: orderBloc.orderByOrderId,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.items.length == 0)
                        return Center(child: Text("No orders Found"));
                      return Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.green,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2.0,
                                        blurRadius: 2.0,
                                        color: Colors.grey)
                                  ]),
                              child: Center(
                                  child: Text(
                                      "Your Orders Status is ${snapshot.data.data.status}",
                                      style: TextStyle(color: Colors.white)))),
                          snapshot.data.data.status == "Submitted"
                              ? OutlineButton.icon(
                                  icon: Icon(Icons.delete_outline_outlined),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  label: Text(
                                    "Cancel Order",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  splashColor: Colors.grey,
                                  highlightedBorderColor: Colors.red,
                                  onPressed: () async {
                                    await showProgressBar(progressDialog);
                                    orderBloc
                                        .cancelOrder(
                                            widget.orderId, userId, "5")
                                        .then((value){

                                      if (value.result == "true") {
                                        hideProgressBar(progressDialog);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    CancelOrderPage()));
                                      } else {
                                        hideProgressBar(progressDialog)
                                            .then((value) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Center(
                                                    child: Text(
                                                        "Cancellation Error"),
                                                  ),
                                                  content: Text(
                                                      "There was some error in cancellation"),
                                                  actions: [
                                                    RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                      color: Colors.grey,
                                                      textColor: Colors.black,
                                                      child: Center(
                                                        child: Text("Ok"),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ],
                                                );
                                              });
                                        });
                                      }
                                    });
                                  },
                                )
                              : Container(),
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            child: TabBar(
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Products',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Payment / Shipment',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)
                                  ),
                                ),
                              ],
                              indicatorColor: HexColor("#2EB2F2"),
                              labelColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorWeight: 3.0,
                              indicatorPadding: EdgeInsets.all(10),
                              isScrollable: true,
                              controller: _tabController,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            //height: MediaQuery.of(context).size.height * 0.65,
                            child: new TabBarView(
                                controller: _tabController,
                                children: <Widget>[
                                  ListView.builder(
                                    itemBuilder: (context, int index) {
                                      return ProductListWidget(
                                        orderModel:
                                            snapshot.data.data.items[index],
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.data.items.length,
                                  ),
                                  ListView(shrinkWrap: true, children: [
                                    PaymentDetailsWidget(order: snapshot.data),
                                    ShippingDetails(order: snapshot.data)
                                  ])
                                ]),
                          ))
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error"));
                    }
                    return Center(child: Text("Loading"));
                  }),
            ));
  }
}

class ShippingDetails extends StatelessWidget {
  final Orders order;
  const ShippingDetails({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(spreadRadius: 2.0, blurRadius: 2.0, color: Colors.grey)
          ]),
      child: ListView(
        //padding: const EdgeInsets.all(20.0),
        shrinkWrap: true,
        children: [
          Text(
            "Shipping Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Orderer First Name ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${order.data.fname}",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Orderer Last Name ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${order.data.lname}",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentDetailsWidget extends StatelessWidget {
  final Orders order;
  const PaymentDetailsWidget({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(spreadRadius: 2.0, blurRadius: 2.0, color: Colors.grey)
            ]),
        child: ListView(shrinkWrap: true, children: [
          Text(
            "Payment Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Number Of Items"),
              Text(
                  "${order.data.items.length == null ? 'Unknown' : order.data.items.length}")
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Total Item Price : ")),
              Image.asset(
                "assets/rupee_sign.jpg",
                width: 10.0,
                height: 10.0,
              ),
              Text("${order.data.orderAmount}")
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Total  : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                "assets/rupee_sign.jpg",
                width: 10.0,
                height: 10.0,
              ),
              Text("${order.data.orderAmount}",
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ]));
  }
}

class ProductListWidget extends StatelessWidget {
  OrderItem orderModel;
  ProductListWidget({this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(spreadRadius: 2.0, blurRadius: 2.0, color: Colors.grey)
          ]),
      child: Row(
        children: [
          Image.network(
            orderModel.image,
            height: 80,
            width: 80,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Name : ${orderModel.name}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Quantity : ${orderModel.qty} "),
              Text("Price : Rs. ${orderModel.price}")
            ],
          )),
        ],
      ),
    );
  }
}
