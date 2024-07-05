import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/payment_provider.dart';

class ConfirmationDialog extends StatelessWidget {
  final String amount;

  const ConfirmationDialog({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Payment'),
      content: const Text('Are you sure you want to proceed with the payment?'),
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
            var paymentProvider =
                Provider.of<PaymentProvider>(context, listen: false);
            paymentProvider.openPaymentGateway(context, amount);
          },
        ),
      ],
    );
  }
}
