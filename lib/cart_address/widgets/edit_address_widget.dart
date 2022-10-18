import 'package:eazy_shop/models/cart/address_model.dart';
import 'package:flutter/material.dart';

class EditAddressWidget extends StatefulWidget {
  AddressModel addressModel;
  Function callback;
  EditAddressWidget({this.addressModel, this.callback});
  EditAddressWidgetState createState() => EditAddressWidgetState();
}

class EditAddressWidgetState extends State<EditAddressWidget> {
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        "Edit Address",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {
              widget.callback(widget.addressModel);
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: Center(
                child: Text(
              "Update",
              style: TextStyle(fontWeight: FontWeight.bold),
            )))
      ],
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView(
          children: [
            TextFormField(
              maxLines: 3,
              initialValue: widget.addressModel.address,
              onChanged: (val) {
                setState(() {
                  widget.addressModel.address = val.trim();
                });
              },
            ),
            TextFormField(
              initialValue: widget.addressModel.city,
              onChanged: (val) {
                setState(() {
                  widget.addressModel.city = val.trim();
                });
              },
            ),
            TextFormField(
              initialValue: widget.addressModel.state,
              onChanged: (val) {
                setState(() {
                  widget.addressModel.state = val.trim();
                });
              },
            ),
            TextFormField(
              initialValue: widget.addressModel.pincode,
              onChanged: (val) {
                setState(() {
                  widget.addressModel.pincode = val.trim();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
