
import 'package:eazy_shop/network/client_functions.dart';
import 'package:eazy_shop/user_data/otp_verify.dart';
import 'package:eazy_shop/utils/custom_popups.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UserMobileVerify extends StatefulWidget {
  UserMobileVerifyState createState() => UserMobileVerifyState();
}

class UserMobileVerifyState extends State<UserMobileVerify> {
  String mobileNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Image.asset("assets/mobile.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(20.0),
                decoration: new BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Mobile Number Verification",
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Keep your data secure using two step mobile number verification",
                        style: GoogleFonts.montserrat(fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: mobileNumber,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                            labelText: "Your Phone number with +91",
                            icon: Icon(Icons.phone_iphone)),
                        onChanged: (val) {
                          setState(() {
                            mobileNumber = val;
                          });
                        },
                      ),
                    ),
                    SendOtpBoxContainer(mobileNumber: mobileNumber)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SendOtpBoxContainer extends StatefulWidget {
  final String mobileNumber;
  SendOtpBoxContainer({this.mobileNumber});
  SendOtpBoxContainerState createState() => SendOtpBoxContainerState();
}

class SendOtpBoxContainerState extends State<SendOtpBoxContainer> {
  String buttonText = "Send OTP";
  bool enabled = true;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: enabled
            ? () async {
                widget.mobileNumber == ""
                    ? CustomPopups.showToastMessage("Please enter valid Number")
                    : setState(() {
                        buttonText = "Loading..";
                        enabled = false;
                        getOtp(widget.mobileNumber).then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => OTPVerification()));
                        }).catchError((error) {
                          print("error: " + error.toString());
                        });
                      });
              }
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: new Text(
            buttonText,
            style: new TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        color: Colors.blueAccent,
      ),
    );
  }
}
