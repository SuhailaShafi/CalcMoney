import 'package:flutter/material.dart';

class TransactionDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const TransactionDetailItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
