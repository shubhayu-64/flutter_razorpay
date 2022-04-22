import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:razorpay/models/models.dart';

class OrderHandle {
  Future<Order> getOrder() async {
    var client = http.Client();
    var uri = Uri.parse("https://api.razorpay.com/v1/orders");

    var response = await client.post(uri);
  }
}
