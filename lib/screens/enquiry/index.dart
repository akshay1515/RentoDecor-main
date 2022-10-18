import 'package:eazy_shop/bloc/enquiry_bloc.dart';
import 'package:eazy_shop/models/enquiry/enquiry.dart';
import 'package:eazy_shop/success/index.dart';
import 'package:eazy_shop/utils/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnquiryPage extends StatefulWidget {
  final String userId, productId;
  EnquiryPage({this.userId, this.productId});
  EnquiryPageState createState() => EnquiryPageState();
}

class EnquiryPageState extends State<EnquiryPage> {
  String contact, description, userName = '';
  bool isEnabled = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.08),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor("#2EB2F2"), HexColor("#2361AE")],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text("Enquiry",
                      style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: isEnabled
              ? () async {
                  setState(() {
                    isEnabled = false;
                  });
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await enquiryBloc.createEnquiry(EnquiryModel(widget.userId,
                        userName, contact, description, widget.productId));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => SuccessPage()));
                  }
                }
              : null,
          label: Text("Save"),
          icon: Icon(Icons.check),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: userName,
                  validator: (val) {
                    if (val.isEmpty) return "Please Enter Username";
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      userName = val.trim();
                    });
                  },
                  decoration: InputDecoration(labelText: "Please Enter Name"),
                ),
                TextFormField(
                  initialValue: contact,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val.isEmpty) return "Please Enter Contact Number";
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      contact = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Please Enter Your Contact Number"),
                ),
                TextFormField(
                  initialValue: description,
                  validator: (val) {
                    if (val.isEmpty) return "Please Enter Description";
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      description = val.trim();
                    });
                  },
                  decoration:
                      InputDecoration(labelText: "Please Enter Description"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
