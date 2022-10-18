class CartServerModel {
  int total, offerId;
  String userId,
      date,
      time,
      address,
      discountAmt,
      deliveryCharges,
      payable,
      text;
  List<CartProducts> products;

  CartServerModel(
      {this.userId,
      this.total,
      this.offerId,
      this.date,
      this.time,
      this.address,
      this.discountAmt,
      this.deliveryCharges,
      this.payable,
      this.text,
      this.products});
}

class CartProducts {
  int productId, quantity;

  CartProducts(this.productId, this.quantity);
  toJson() {
    return {"productId": productId, "quantity": quantity};
  }
}
