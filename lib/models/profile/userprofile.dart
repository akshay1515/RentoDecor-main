class userProfile_model {
  String result;
  String message;
  var data;

  userProfile_model({this.result, this.message, this.data});

  userProfile_model.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String fname;
  String lname;
  String email;
  String phone;
  String address;
  String city;
  String userType;
  String status;
  String createdAt;
  String token;
  String pincode;
  String otp;
  String otpExpiryTime;

  Data(
      {this.id,
        this.fname,
        this.lname,
        this.email,
        this.phone,
        this.address,
        this.city,
        this.userType,
        this.status,
        this.createdAt,
        this.token,
        this.pincode,
        this.otp,
        this.otpExpiryTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    userType = json['userType'];
    status = json['status'];
    createdAt = json['createdAt'];
    token = json['token'];
    pincode = json['pincode'];
    otp = json['otp'];
    otpExpiryTime = json['otpExpiryTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['userType'] = this.userType;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['token'] = this.token;
    data['pincode'] = this.pincode;
    data['otp'] = this.otp;
    data['otpExpiryTime'] = this.otpExpiryTime;
    return data;
  }
}
