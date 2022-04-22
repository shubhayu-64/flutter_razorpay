import 'package:flutter/material.dart';
import 'package:razorpay/models/models.dart';
import 'package:razorpay/servives/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _razorpay = Razorpay();
  Order? orderDetails;

  getData() async {
    orderDetails = await OrderHandle().getOrder();
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Error Response: $response');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print('External SDK Response: $response');
  }
// MIr4H6uK6tebUGCpIYMGIHdp

  void openCheckout() async {
    getData();
    var options = {
      'key': 'rzp_test_mWdZk20UX7IlbJ',
      'amount': 50000, //in the smallest currency sub-unit.
      'name': 'IIC TMSL',
      'order_id': orderDetails!.id, // Generate order_id using Orders API
      'description': 'Envisage T-Shirt',
      'timeout': 600, // in seconds
      'prefill': {
        'contact': '7679325872',
        'email': 'shubhayumajumdar@gmail.com'
      },
      "external": ['paytm']
    };

    try {
      _razorpay.open(options);
    } catch (err) {
      debugPrint('Error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Razorpay App"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: openCheckout,
                icon: const Icon(Icons.payment),
              ),
              TextButton(
                onPressed: openCheckout,
                child: const Text("Pay Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
