import 'package:carousel_slider/carousel_slider.dart';
import 'package:eazy_shop/models/offers/offers_list.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eazy_shop/bloc/offer_bloc.dart';

class OffersPage extends StatefulWidget {
  OffersPageState createState() => OffersPageState();
}

class OffersPageState extends State<OffersPage> {
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    offerBloc.getOffers();
    return StreamBuilder<Offers>(
        stream: offerBloc.categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                HexColor("#2EB2F2"),
                                HexColor("#2361AE")
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0))),
                    ),
                    Positioned(
                      left: 20.0,
                      right: 20.0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text("Offers",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))),
                            IconButton(onPressed: (){
                              Fluttertoast.showToast(msg: 'Notification feature will be avaliable soon',toastLength: Toast.LENGTH_LONG);
                            }, icon: Icon(
                              Icons.notification_important_outlined,
                              color: Colors.white,
                            ))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: 0.0,
                      right: 0.0,
                      child: Column(
                        children: [
                          CarouselSlider(
                              options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                              items: snapshot.data.data.map((card) {
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      color: Colors.white,
                                      child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Image.network(
                                              "${card.image}",
                                              fit: BoxFit.cover,
                                            )),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Html(data: card.description),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              card.title,
                                              style: TextStyle(
                                                  color: HexColor("#FFCC00")),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              "Min Bill Amount ${card.minBillAmt}",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 24.0,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Click Here",
                                                  textAlign: TextAlign.end,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                  size: 12.0,
                                                )
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              }).toList()),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  map<Widget>(snapshot.data.data, (index, url) {
                                return Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == index
                                        ? Colors.blueAccent
                                        : Colors.grey,
                                  ),
                                );
                              }))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          return Center(child: Text("Loading"));
        });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
