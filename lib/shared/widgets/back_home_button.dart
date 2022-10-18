import 'package:eazy_shop/Home_screen/main_screen.dart';
import 'package:flutter/material.dart';

class BackToHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => MainScreen()));
        },
        color: Colors.blue,
        textColor: Colors.white,
        child: Center(
          child: Text(
            "Back To Home",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
