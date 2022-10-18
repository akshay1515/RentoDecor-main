import 'package:eazy_shop/inherited/cart_container.dart';
import 'package:eazy_shop/models/cart/cart_product_model.dart';
import 'package:eazy_shop/services/sqflite/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CartItem extends StatefulWidget {
  CartProductModel product;

  CartItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  CartItemState createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.35,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 0.75))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.35,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.product.product.img1,
                        ),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.product.product.name,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/rupee_sign.jpg",
                          width: 10.0,
                          height: 10.0,
                        ),
                        Expanded(
                            child: Text(
                          "${widget.product.model.quantity * double.parse(widget.product.product.price)}",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                        Text(
                          widget.product.model.quantity.toString(),
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return UpdateQuantityContainer(
                                        model: widget.product,
                                        callback: callBack);
                                  });
                            },
                            child: IconButton(
                              icon: Icon(Icons.edit),
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            child: IconButton(
              onPressed: () async {
                await CartContainer.of(context)
                    .removeItemFromCart(widget.product.model.id);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  callBack(int productId, int quantity) async {
    await CartContainer.of(context).updateCartPricing(productId, quantity);
  }
}

class UpdateQuantityContainer extends StatefulWidget {
  final CartProductModel model;
  Function callback;

  UpdateQuantityContainer({this.model, this.callback});

  UpdateQuantityContainerState createState() => UpdateQuantityContainerState();
}

class UpdateQuantityContainerState extends State<UpdateQuantityContainer> {
  TextEditingController _quantity = TextEditingController();
  bool isEnabled = true;

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update Qunatity"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: TextFormField(
        keyboardType: TextInputType.number,
        controller: _quantity,
        decoration: InputDecoration(labelText: "Enter The Quantity"),
      ),
      actions: [
        RaisedButton(
          onPressed: isEnabled
              ? () async {
                  setState(() {
                    isEnabled = true;
                  });
                  widget.callback(int.parse(widget.model.product.id),
                      int.parse(_quantity.text));
                  Navigator.pop(context);
                }
              : null,
          color: Colors.blue,
          child: Center(
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
