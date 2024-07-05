import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rexparts/main.dart';

class PaymentService {
  late Razorpay razorpay;

  PaymentService() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
  }

  void dispose() {
    razorpay.clear();
  }

  void openPaymentGateway(BuildContext context, String amount) {
    var options = {
      "key": "rzp_test_CYrnTOG3W2cDCB",
      "amount": num.parse(amount) * 100,
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
  }

  void _handlerPaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
      msg: 'Payment Success :${response.paymentId}',
      toastLength: Toast.LENGTH_SHORT,
    );

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
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: 'Payment failed : ${response.message}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _handlerExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: 'External Wallet : ${response.walletName}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
