import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeadingAddWidget extends StatelessWidget {
  const HeadingAddWidget({
    super.key,
    required this.hd,
    required this.headingC,
    required bool validate,
  }) : _validate = validate;

  final FocusNode hd;
  final TextEditingController headingC;
  final bool _validate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: TextField(
        maxLength: 12,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        focusNode: hd,
        controller: headingC,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Heading',
          errorText: _validate ? 'Required' : null,
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
      ),
    );
  }
}
