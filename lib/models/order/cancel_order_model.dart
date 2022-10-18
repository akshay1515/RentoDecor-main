class CancelOrderModel {
  String result, message;

  CancelOrderModel(this.result, this.message);
  factory CancelOrderModel.fromMap(Map<String, dynamic> json) {
    return new CancelOrderModel(json['result'], json['message']);
  }
}
