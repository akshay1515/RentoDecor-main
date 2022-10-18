import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarWidget extends StatelessWidget {
  String title;
  CustomAppBarWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 100),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
        ]),

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.1,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [HexColor("#2EB2F2"),HexColor("#2361AE")],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: ()=>Navigator.pop(context),
                  icon: Icon(
                    Icons.navigate_before,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                    title,
                    style: GoogleFonts.montserrat(fontSize: 26.0,color: Colors.white)
                ),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.notification_important_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
