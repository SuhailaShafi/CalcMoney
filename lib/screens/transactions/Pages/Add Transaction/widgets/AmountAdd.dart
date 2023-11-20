import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountAddWidget extends StatelessWidget {
  const AmountAddWidget({
    super.key,
    required this.am,
    required this.amountC,
    required bool validate,
  }) : _validate = validate;

  final FocusNode am;
  final TextEditingController amountC;
  final bool _validate;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19),
        child: TextFormField(
          focusNode: am,
          controller: amountC,
          validator: (value) => value!.isEmpty ? 'Enter an amount' : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Amount',
            errorText: _validate ? 'enter amount' : null,
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.grey),
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      ),
    );
  }
}
