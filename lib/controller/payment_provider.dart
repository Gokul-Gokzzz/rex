import 'package:flutter/material.dart';
import 'package:rexparts/service/payment_service.dart';

class PaymentProvider with ChangeNotifier {
  final PaymentService _paymentService = PaymentService();

  void openPaymentGateway(BuildContext context, String amount) {
    _paymentService.openPaymentGateway(context, amount);
  }

  @override
  void dispose() {
    _paymentService.dispose();
    super.dispose();
  }
}
