import 'package:eazy_shop/Home_screen/main_screen.dart';
import 'package:eazy_shop/shared/widgets/back_home_button.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessPage extends StatefulWidget {
  SuccessPageState createState() => SuccessPageState();
}

class SuccessPageState extends State<SuccessPage> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                Text("Order Placed",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: SizedBox()),
            Image.asset("assets/logo.jpg"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "GREAT!",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(),
            Text(
              "Your Order has been Placed.We will reach out to you shortly with your order",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            BackToHomePage(),
            Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
