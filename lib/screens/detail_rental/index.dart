import 'package:eazy_shop/bloc/product_bloc.dart';
import 'package:eazy_shop/cart/index.dart';
import 'package:eazy_shop/models/product/product_list.dart';
import 'package:eazy_shop/services/sqflite/database_helper.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:eazy_shop/utils/custom_popups.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRentalPage extends StatefulWidget {
  final String id;
  ProductRentalPage({this.id});
  ProductRentalPageState createState() => ProductRentalPageState();
}

class ProductRentalPageState extends State<ProductRentalPage> {
  SharedPreferences _preferences;
  String userId = '';
  bool _isLoading = true;
  double price = 0.0;
  int quantity = 1;
  TextEditingController _quantityController = new TextEditingController();

  void initState() {
    super.initState();
    _initializePreference();
  }

  _initializePreference() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      if (_preferences.containsKey("user")) {
        userId = _preferences.getString("user");
      }
      _isLoading = false;
    });
  }

  calculate(){
    return price*quantity;
  }

  Widget build(BuildContext context) {
    productBloc.getProductById(widget.id);
    return _isLoading
        ? Scaffold(
            body: Center(child: Text("Loading")),
          )
        : SafeArea(
            top: true,
            child: Scaffold(
              bottomNavigationBar: Container(
                margin: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      try {
                        int inserted = await DatabaseHelper.instance.addtoCart({
                          DatabaseHelper.cart_id:
                              userId != "" ? int.parse(userId) : 1,
                          DatabaseHelper.product_id: int.parse(widget.id),
                          DatabaseHelper.quantity: quantity
                        });
                        if (inserted != 0)
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  title: Text("Product Added"),
                                  content:
                                      Text("Product is Successfully added"),
                                  actions: [
                                    RaisedButton(
                                      color: Colors.blue,
                                      onPressed: () => Navigator.pop(context),
                                      child: Center(
                                        child: Text("Ok"),
                                      ),
                                    )
                                  ],
                                );
                              });
                        else {
                          CustomPopups.showToastMessage(
                              "Product Already Exists");
                        }
                      } on Exception catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Text("Error"),
                                content: Text("There was an error encountered"),
                              );
                            });
                      }
                      /*Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => CartPage()));*/
                    },
                    child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "ADD TO CART",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  '₹ ${calculate().toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                HexColor("#2DA3DE"),
                                HexColor("#206AB5")
                              ])),
                    ),
                  ),
                ),
              ),
              body: StreamBuilder<Products>(
                  stream: productBloc.categories,
                  builder: (context, snapshot) {

                      price = double.parse(snapshot.data.data[0].price);

                    if (snapshot.hasData) {
                      if (snapshot.data.data.length == 0)
                        return Scaffold(
                            body: Center(
                                child: Text("No Info Found For Product")));
                      return ListView(
                        padding: const EdgeInsets.all(0.0),
                        children: [
                          Stack(children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                "${snapshot.data.data[0].img1}",
                                fit: BoxFit.fill,
                              ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8.0,
                                        offset: Offset(0.0, 0.25))
                                  ],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  )),
                            ),
                            Positioned(
                              top: 30.0,
                              left: 20.0,
                              right: 20.0,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(0.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.navigate_before,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(0.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      CartPage()));
                                        },
                                        icon: Icon(Icons.shopping_cart,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,bottom: 20.0,left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data.data[0].name,
                                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                                      ),
                                      /*Html(
                                        data: snapshot.data.data[0].description,
                                      ),*/
                                    ],
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          "assets/rupee_sign.jpg",
                                          width: 10.0,
                                          height: 10.0,
                                        ),
                                        Text(
                                          snapshot.data.data[0].price,
                                          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.075,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 5.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(0.0, 0.75))
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("assets/qty.png"),
                                        ),
                                        Text(
                                          "Required Quantity",
                                          style: TextStyle(fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                title: Text("Update Qunatity"),
                                                content: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      _quantityController,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "Enter The Quantity"),
                                                ),
                                                actions: [
                                                  RaisedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        quantity = int.parse(
                                                            _quantityController
                                                                .text);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    color: Colors.blue,
                                                    child: Center(
                                                      child: Text(
                                                        "Ok",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1.0)),
                                          child: Text(quantity.toString(),style: TextStyle(fontWeight: FontWeight.bold),)))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Divider(
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 14.0,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ListView.builder(
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              content: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  child:
                                                      PhotoViewGallery.builder(
                                                    scrollPhysics:
                                                        const BouncingScrollPhysics(),
                                                    builder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return PhotoViewGalleryPageOptions(
                                                        imageProvider: AssetImage(
                                                            "assets/guitar.jpg"),
                                                        initialScale:
                                                            PhotoViewComputedScale
                                                                .covered,
                                                        maxScale:
                                                            PhotoViewComputedScale
                                                                .covered,
                                                        minScale: PhotoViewComputedScale
                                                            .covered,
                                                        heroAttributes:
                                                            PhotoViewHeroAttributes(
                                                                tag: index),
                                                      );
                                                    },
                                                    itemCount: 5,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  )));
                                        },
                                        barrierDismissible: true);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/guitar.jpg")),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Divider(
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 10.0,),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 10.0),
                            child: Html(
                              data: snapshot.data.data[0].description,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error"));
                    }
                    return Scaffold(body: Center(child: Text("Loading...")));
                  }),
            ),
          );
  }
}
