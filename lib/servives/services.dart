import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:razorpay/models/models.dart';

class OrderHandle {
  Future<Order> getOrder() async {
    String username = 'rzp_test_mWdZk20UX7IlbJ';
    String password = 'MIr4H6uK6tebUGCpIYMGIHdp';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    Map<String, String> headers = {
      'content-type': 'application/json',
      'authorization': basicAuth
    };

    Map<String, String> body = {
      "amount": (50000).toString(),
      "currency": "INR",
      "receipt": "receipt 10",
    };

    var client = http.Client();
    var uri = Uri.parse("https://api.razorpay.com/v1/orders");

    var response = await client.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      var json = response.body;
      return orderFromJson(json);
    } else {
      print("\n\nerror broooo\n\n");
      throw "error";
    }
  }
}
