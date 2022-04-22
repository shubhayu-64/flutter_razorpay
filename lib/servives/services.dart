import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:razorpay/models/models.dart';

class OrderHandle {
  Future<Order> getOrder() async {
    var amount = 10;
    var receipt = "receipt 1";

    var client = http.Client();
    var uri = Uri.parse(
        "https://flutter-backend.shubho64.repl.co/orderid?amount=$amount&receipt=$receipt");

    var response = await client.post(
      uri,
    );

    if (response.statusCode == 200) {
      var json = response.body;
      return orderFromJson(json);
    } else {
      // response = response.toString()
      throw "error";
    }
  }
}
