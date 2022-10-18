import 'dart:convert';

import 'package:eazy_shop/models/login/send_otp.dart';
import 'package:eazy_shop/models/login/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String _baseUrl =
    "http://yontechsoftwares.com/share/swastik/index.php/Api/sendOtp";
Future<SendOtpModel> getOtp(String number) async {
  http.Client client = http.Client();
  final http.Response response = await client.post(
    Uri.parse(_baseUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'mobile': number,
      'userType': 'Customer',
      'apiVersion': '1.0'
    }),
  );

  if (response.statusCode == 200) {
    client.close();
    final parsed = jsonDecode(response.body);
    print(response.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("mobile", number);
    return SendOtpModel.fromJson(parsed);
  } else {
    client.close();
    throw Exception('Failed to Get Otp.');
  }
}

Future<SendOtpModel> resendOtp(String number) async {
  http.Client client = http.Client();
  final http.Response response = await client.post(
   Uri.parse( "http://yontechsoftwares.com/share/swastik/index.php/Api/resendOTP",),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'mobile': number,
      'userType': 'Customer',
      'apiVersion': '1.0'
    }),
  );

  if (response.statusCode == 200) {
    client.close();
    final parsed = jsonDecode(response.body);
    return SendOtpModel.fromJson(parsed);
  } else {
    client.close();
    throw Exception('Failed to Get Otp.');
  }
}

Future<UserModel> verifyOtp(String mobile, String otp) async {
  http.Client client = http.Client();
  Map data = {
    "mobile": mobile,
    "userType": "Customer",
    "otp": otp,
    "apiVersion": "1.0",
    "imei": "1",
    "otpExpiryTime": "1"
  };



  final http.Response response = await client.post(
    Uri.parse("http://yontechsoftwares.com/share/swastik/index.php/Api/verifyOtp",),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    client.close();
    print(response.body);
    final parsed = jsonDecode(response.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModel model = UserModel.fromJson(parsed);
    preferences.setString("user", model.data.userId);
    return UserModel.fromJson(parsed);
  } else {
    client.close();
    throw Exception('Failed to Get Otp.');
  }
}
