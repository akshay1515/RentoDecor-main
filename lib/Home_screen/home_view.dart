
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:eazy_shop/bloc/cat_bloc.dart';
import 'package:eazy_shop/bloc/offer_bloc.dart';
import 'package:eazy_shop/models/cat/cat_list.dart';
import 'package:eazy_shop/models/home_data_model.dart';
import 'package:eazy_shop/models/offers/offers_list.dart';
import 'package:eazy_shop/screens/offers/index.dart';

import 'package:eazy_shop/screens/search/search_page.dart';
import 'package:eazy_shop/screens/search_page/index.dart';
import 'package:eazy_shop/screens/search_rental/index.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    catBloc.getCategories();
    offerBloc.getOffers();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    //fit: StackFit.loose,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        color: Colors.white,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            gradient: LinearGradient(
                                colors: [
                                  HexColor("#2EB2F2"),
                                  HexColor("#2361AE")
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ),
                      _appBar(context),
                      _headerSection(context),
                      _textWidgetBox(context)
                    ],
                  ),
                  ListContainerWidget(),
                  ListContainerWidget2()
                ],
              ),
            ),
          )),
    );
  }

  Positioned _textWidgetBox(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.225,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          padding: const EdgeInsets.all(5.0),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 2.0,
                    spreadRadius: 2.0)
              ]),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => SearchBarPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Search"), Icon(Icons.search)],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _headerSection(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 55.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage("assets/face.jpg"),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Hi Neha',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Text(
                      'Good Morning',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Positioned _appBar(BuildContext context) {
    return Positioned(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Container(),
            Text(
              "Rento Decor",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            IconButton(onPressed: (){
              Fluttertoast.showToast(msg: 'Notification feature will be avaliable soon',toastLength: Toast.LENGTH_LONG);
            }, icon: Icon(Icons.notification_important, color: Colors.white),)
          ],
        ),
      ),
    );
  }
}

class ListContainerWidget extends StatelessWidget {
  ListContainerWidget({
    Key key,
  }) : super(key: key);

  List<ServicesModel> model = [
    new ServicesModel(imageUrl: "assets/dinner.png", title: "Party Rental"),
    new ServicesModel(
        imageUrl: "assets/balloon.png", title: "Party Decoration"),
    new ServicesModel(imageUrl: "assets/rhythm.png", title: "Band")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left:20.0,bottom: 20,right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Browse By Categories",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            /*IconButton(onPressed: (){

            }, icon: Icon(Icons.arrow_forward))*/
          ]),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.165,
          //margin: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: catBloc.categories,
              builder: (context, AsyncSnapshot<Categories> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            if (snapshot.data.data[index].type == "0") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => SearchRentalPage(
                                          categoryId:
                                              snapshot.data.data[index].id,
                                          pageTitle: snapshot
                                              .data.data[index].categoryName)));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => SearchPage(
                                          categoryId:
                                              snapshot.data.data[index].id,
                                          pageTitle: snapshot
                                              .data.data[index].categoryName)));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            snapshot.data.data[index].image)),
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.redAccent,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                    child: Text(
                                  snapshot.data.data[index].categoryName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 12.0),
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.data.length);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Text("Loading");
              }),
        )
      ],
    );
  }
}

class ListContainerWidget2 extends StatelessWidget {
  ListContainerWidget2({
    Key key,
  }) : super(key: key);

  List<ServicesModel> model = [
    new ServicesModel(imageUrl: "assets/dinner.png", title: "Party Rental"),
    new ServicesModel(
        imageUrl: "assets/balloon.png", title: "Party Decoration"),
    new ServicesModel(imageUrl: "assets/rhythm.png", title: "Band")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left:20.0,bottom: 20,right: 20,top: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Browse By Offers",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
               /* IconButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (ctx)=>OffersPage()));
                }, icon: Icon(Icons.arrow_forward))*/
          ]),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.165,
          //margin: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: offerBloc.categories,
              builder: (context, AsyncSnapshot<Offers> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => SearchRentalPage(
                                        categoryId:
                                            snapshot.data.data[index].id,
                                        pageTitle:
                                            snapshot.data.data[index].title)));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            width: MediaQuery.of(context).size.width * 0.3,

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.225,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            snapshot.data.data[index].image)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                    child: Text(
                                  snapshot.data.data[index].title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 13),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.data.length);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Text("Loading");
              }),
        )
      ],
    );
  }
}
