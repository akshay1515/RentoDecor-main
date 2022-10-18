import 'package:eazy_shop/bloc/cart_server_bloc.dart';
import 'package:eazy_shop/cart_address/widgets/edit_address_widget.dart';
import 'package:eazy_shop/models/cart/address_model.dart';
import 'package:eazy_shop/models/cart/cart_product_model.dart';
import 'package:eazy_shop/models/cart/cart_server_order.dart';
import 'package:eazy_shop/screens/transaction_failed/index.dart';
import 'package:eazy_shop/services/sqflite/database_helper.dart';
import 'package:eazy_shop/success/index.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:eazy_shop/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartAddressPage extends StatefulWidget {
  Map<int, CartProductModel> cartModel;
  CartAddressPage({this.cartModel});
  CartAddressPageState createState() => CartAddressPageState();
}

class CartAddressPageState extends State<CartAddressPage> {
  CartServerModel _cartServerModel;
  AddressModel _addressModel = new AddressModel(
      "ABC, EFG, XYZ,Street, Coner Side", "Nashik", "Maharashtra", "171021");
  bool _isLoading = true;
  int totalProductsAmount = 0;
  int totalCartAmount = 0;
  ProgressDialog progressDialog;
  SharedPreferences _preferences;
  String userId = "";
  String address, city, state, pincode = "";
  bool _addressEditable = false;
  int _orderChannelVal = 0;
  void initState() {
    super.initState();
    address = _addressModel.address;
    city = _addressModel.city;
    state = _addressModel.state;
    pincode = _addressModel.pincode;
    initializePreference();
  }

  initializePreference() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      if (_preferences.containsKey("user")) {
        userId = _preferences.getString("user");
        _calculateTotalAmount();
        _isLoading = false;
      }
    });
  }

  _calculateTotalAmount() {
    setState(() {
      _cartServerModel = new CartServerModel(
          userId: userId,
          deliveryCharges: "150",
          discountAmt: "50",
          offerId: 9,
          text: "This is my order",
          products: [],
          date: DateTime.now().toString(),
          time: DateTime.now().toString(),
          address: "Test");
      for (var e in widget.cartModel.keys) {
        _cartServerModel.products
            .add(CartProducts(e, widget.cartModel[e].model.quantity));
        totalCartAmount +=
            int.parse(widget.cartModel[e].product.price.split(".")[0]) *
                widget.cartModel[e].model.quantity;
      }
      totalProductsAmount = totalCartAmount;
      _cartServerModel.total = totalProductsAmount;
      _cartServerModel.payable = totalProductsAmount.toString();
      _cartServerModel.address = _addressModel.city;
      totalCartAmount = (totalCartAmount - 50) + 150;
    });
  }

  Widget build(BuildContext context) {
    progressDialog = createProgressDialogObject(context);
    styleProgressDialog(progressDialog, 'Creating Order For You');
    return _isLoading
        ? Scaffold(
            body: Center(child: Text("Loading")),
          )
        : SafeArea(
            top: true,
            child: Scaffold(
              bottomNavigationBar: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [HexColor("#0E96D9"), HexColor("#2273BB")])),
                child: InkWell(
                  onTap: () async {
                    _cartServerModel.address = _addressModel.city;
                    _cartServerModel.userId = userId;
                    await showProgressBar(progressDialog);
                    cartServerBloc
                        .createOrder(_cartServerModel)
                        .then((createOrderResponse) {
                      DatabaseHelper.instance
                          .makeCartEmpty(userId != "" ? int.parse(userId) : 1)
                          .then((value) {
                        if (!createOrderResponse.orderId.isEmpty) {
                          if (_orderChannelVal == 0) {
                            cartServerBloc
                                .callPaytm(
                                    _cartServerModel, createOrderResponse)
                                .then((response) {
                              if (response['error']) {
                                hideProgressBar(progressDialog).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              TransactionFailedPage(
                                                  message: response[
                                                      "errorMessage"])));
                                });
                              } else {
                                hideProgressBar(progressDialog).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => SuccessPage()));
                                });
                              }

                              //TODO- Start from here
                              /*if (value['error']) {
                                payment_response = value['errorMessage'];
                              } else if (value['response'] != null) {
                                payment_response = value['response']['STATUS'];
                              }*/
                            });
                          } else {
                            DatabaseHelper.instance
                                .makeCartEmpty(
                                    userId != "" ? int.parse(userId) : 1)
                                .then((value) {
                              hideProgressBar(progressDialog).then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => SuccessPage()));
                              });
                            });
                          }
                        }
                      });
                    }).catchError((err) async {
                      await hideProgressBar(progressDialog);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Total Paid",
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rs. ${totalCartAmount}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ])
                        ],
                      ),
                      Container(
                        width: 2.0,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Checkout",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
              ),
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
                      Text("Address",
                          style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      Expanded(child: SizedBox()),
                      Icon(
                        Icons.notification_important_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return EditAddressWidget(
                                                  addressModel: _addressModel,
                                                  callback: (AddressModel
                                                      addressModel) {
                                                    setState(() {
                                                      _addressModel =
                                                          addressModel;
                                                      Navigator.pop(context);
                                                    });
                                                  });
                                            });
                                      })
                                ],
                              ),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    text: "Select Address :",
                                    style: TextStyle(
                                        color: Color(0xFF656565),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text: "${_addressModel.address}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "City : ",
                                    style: TextStyle(
                                        color: Color(0xFF656565),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text: "${_addressModel.city}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "State : ",
                                    style: TextStyle(
                                        color: Color(0xFF656565),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text: "${_addressModel.state}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "Pincode : ",
                                    style: TextStyle(
                                        color: Color(0xFF656565),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text: "${_addressModel.pincode}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        CouponWidget(),
                        Divider(),
                        CalculationBoxes(
                            totalProductsAmount: totalProductsAmount),
                        Divider(),
                        FinalPaidAmountWidget(totalCartAmount: totalCartAmount),
                        Divider(),
                        OrderChannelSelection(
                          orderChannelVal: _orderChannelVal,
                          callback: (val) {
                            setState(() {
                              _orderChannelVal = val;
                            });
                          },
                        ),
                        Expanded(child: SizedBox())
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class OrderChannelSelection extends StatefulWidget {
  int orderChannelVal;
  Function callback;
  OrderChannelSelection({this.orderChannelVal, this.callback});
  OrderChannelSelectionState createState() => OrderChannelSelectionState();
}

class OrderChannelSelectionState extends State<OrderChannelSelection> {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              new Radio(
                value: 0,
                groupValue: widget.orderChannelVal,
                onChanged: (val) {
                  setState(() {
                    widget.orderChannelVal = 0;
                    widget.callback(0);
                  });
                },
              ),
              new Text(
                'Online',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: 1,
                groupValue: widget.orderChannelVal,
                onChanged: (val) {
                  setState(() {
                    widget.orderChannelVal = 1;
                    widget.callback(1);
                  });
                },
              ),
              new Text(
                'Cash On Delivery',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FinalPaidAmountWidget extends StatelessWidget {
  const FinalPaidAmountWidget({
    Key key,
    @required this.totalCartAmount,
  }) : super(key: key);

  final int totalCartAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "To be Paid",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "Rs. ${totalCartAmount}",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CalculationBoxes extends StatelessWidget {
  const CalculationBoxes({
    Key key,
    @required this.totalProductsAmount,
  }) : super(key: key);

  final int totalProductsAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order Total", style: TextStyle(color: Color(0xFF767676))),
              Text(
                "Rs. ${totalProductsAmount}",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rento Decor Discount",
                  style: TextStyle(color: Color(0xFF767676))),
              Text(
                "Rs. 50.00",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Coupon Discount",
                  style: TextStyle(color: Color(0xFF767676))),
              Text(
                "Rs. 00",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping", style: TextStyle(color: Color(0xFF767676))),
              Text(
                "Rs. 150.0",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CouponWidget extends StatelessWidget {
  const CouponWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Enter Coupon Code"),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Apply",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [HexColor("#2DA3DE"), HexColor("#206AB5")])),
            ),
          ),
        ],
      ),
    );
  }
}
