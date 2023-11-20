import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
    required this.hd,
    required this.headingC,
    required this.validate,
  });

  final FocusNode hd;
  final TextEditingController? headingC;
  final bool validate;

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
          errorText: validate ? 'required' : null,
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
