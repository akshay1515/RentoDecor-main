import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfo extends StatefulWidget {
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  SharedPreferences _preferences;
  String userId = '';
  bool _isInitialized = false;
  bool _isLoading = false;
  int count = 0;
  Map userdata = Map();

  initializePreference() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      if (_preferences.containsKey("user")) {
        userId = _preferences.getString("user");
      }

      _isInitialized = true;
    });
  }

  Future getUserData() async {
    String userid = '';
    initializePreference();
    if (_isInitialized && !_isLoading) {
      Response response = await Dio().post(
          'http://yontechsoftwares.com/share/swastik/index.php/Api/getUserById',
          data: {"apiVersion": "1.0", "token": "", "id": userId});

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = response.data as Map;

        return decode;
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading && count < 1) {
      getUserData().then((value) {
        if (value != null) {
          userdata = value;
          setState(() {
            _isLoading = true;
            count = count + 1;
          });
        }
      });
    }
    double _height = MediaQuery.of(context).size.height;
    //double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                Text("Profile",
                    style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  new AssetImage("assets/face.jpg")),
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name',
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 16.0)),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return UpdateWidget(
                                        header: "Update Name",
                                        textLabel: "Enter Name ",
                                      );
                                    });
                              })
                        ]),
                    Text(
                      userdata['data'][0]['fname'].isNotEmpty
                          ? '${userdata['data'][0]['fname']} ${userdata['data'][0]['lname']}'
                          : 'Enter Name',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 16.0),
                          ),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return UpdateWidget(
                                        header: "Update Email",
                                        textLabel: "Enter Email",
                                      );
                                    });
                              })
                        ]),
                    Text(
                      userdata['data'][0]['email'].isNotEmpty
                          ? '${userdata['data'][0]['email']} '
                          : 'Enter email',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 16.0),
                    ),
                    Text(
                      userdata['data'][0]['phone'].isNotEmpty
                          ? '${userdata['data'][0]['phone']}'
                          : 'Enter Mobile Number',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Text(
                      "City",
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 16.0),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userdata['data'][0]['city'].isNotEmpty
                                ? '${userdata['data'][0]['city']}'
                                : 'Enter City',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return UpdateWidget(
                                        header: "Update Blood Group",
                                        textLabel: "Enter Blood Group",
                                      );
                                    });
                              })
                        ]),
                    Divider(color: Colors.grey.shade300),
                    Text(
                      "Address",
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 16.0),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userdata['data'][0]['address'].isNotEmpty
                                ? '${userdata['data'][0]['address']} - ${userdata['data'][0]['pincode']}'
                                : 'Enter Address',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return UpdateWidget(
                                        header: "Update Address",
                                        textLabel: "Enter Address",
                                      );
                                    });
                              })
                        ]),
                    Expanded(child: SizedBox())
                  ],
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  @override
  void initState() {}
}

class UpdateWidget extends StatelessWidget {
  final String header, textLabel;

  UpdateWidget({
    this.header,
    this.textLabel,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(header),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: TextFormField(
        decoration: InputDecoration(labelText: textLabel),
      ),
      actions: [
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.blue,
          child: Center(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        )
      ],
    );
  }
}
