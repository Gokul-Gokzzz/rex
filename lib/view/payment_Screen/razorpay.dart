import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rexparts/controller/cart_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rexparts/main.dart';
import 'package:rexparts/view/order/order.dart';

class PaymentScreen extends StatefulWidget {
  final double productAmount;
  final id;
  const PaymentScreen({super.key, required this.productAmount, this.id});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formkey = GlobalKey();
  late TextEditingController amountController = TextEditingController();
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    amountController =
        TextEditingController(text: widget.productAmount.toString());
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
      msg: 'Payment Success :${response.paymentId}',
      toastLength: Toast.LENGTH_SHORT,
    );

    // Add purchased items to the orders
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    for (var item in cartProvider.cartItems) {
      cartProvider.addOrder(
        item,
      );
      cartProvider.updateCart(id: item.id, isOrder: true);
    }

    // Show notification
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Payment Successful',
      'Your payment was successful. Check your orders.',
      platformChannelSpecifics,
      payload: 'item x',
    );

    // Navigate to the order screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderScreen(),
      ),
    );
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: 'Payment failed : ${response.message}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: 'External Wallet : ${response.walletName}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Payment'),
          content:
              const Text('Are you sure you want to proceed with the payment?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                var options = {
                  "key": "rzp_test_CYrnTOG3W2cDCB",
                  "amount": num.parse(amountController.text) * 100,
                  "name": "Rexparts",
                  "description": "payment for our product",
                  "prefill": {
                    "contact": "8590314865",
                    "email": "rexparts@gmail.com",
                  },
                  "external": {
                    "wallet": ["paytm"]
                  },
                };
                try {
                  razorpay.open(options);
                } catch (e) {
                  log(e.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 14, 121, 243);
    const secondaryColor = Color.fromARGB(255, 9, 2, 104);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Rexparts Payment',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Enter Amount',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: amountController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter the amount',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Please Enter the amount";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!formkey.currentState!.validate()) {
                                return;
                              }
                              formkey.currentState!.save();
                              _showConfirmationDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Pay Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
