import 'package:flutter/material.dart';
// import 'package:razorpay_plugin/razorpay_plugin.dart';
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
    var options = {
      'key': 'rzp_test_mWdZk20UX7IlbJ',
      'amount': 50000, //in the smallest currency sub-unit.
      'name': 'IIC TMSL',
      'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': 'Envisage T-Shirt',
      'timeout': 60, // in seconds
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

  // startPayment() async {
  //   Map<String, dynamic> options = new Map();
  //   options.putIfAbsent("name", () => "Razorpay T-Shirt");
  //   options.putIfAbsent(
  //       "image", () => "https://www.73lines.com/web/image/12427");
  //   options.putIfAbsent("description", () => "This is a real transaction");
  //   options.putIfAbsent("amount", () => "100");
  //   options.putIfAbsent("email", () => "test@testing.com");
  //   options.putIfAbsent("contact", () => "9988776655");
  //   options.putIfAbsent("order_id", () => "order_EMBFqjDHEEn80l");
  //   //Must be a valid HTML color.
  //   options.putIfAbsent("theme", () => "#FF0000");
  //   options.putIfAbsent("api_key", () => "rzp_test_mWdZk20UX7IlbJ");
  //   //Notes -- OPTIONAL
  //   Map<String, String> notes = new Map();
  //   notes.putIfAbsent('key', () => "value");
  //   notes.putIfAbsent('randomInfo', () => "haha");
  //   options.putIfAbsent("notes", () => notes);
  //   Map<dynamic, dynamic> paymentResponse = new Map();
  //   paymentResponse = await Razorpay.showPaymentForm(options);
  //   print("response $paymentResponse");
  // }

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
                onPressed: () {},
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
