import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {

  CustomTextField({this.hint, this.prefix, this.suffix, this.obscure = false,
    this.textInputType, this.onChanged, this.enabled, this.controller, this.validator,
    this.labelText, this.inputFormatters, this.onSaved, this.initialValue
  });

  final TextEditingController controller;
  final String hint;
  final String labelText;
  final Widget prefix;
  final Widget suffix;
  final bool obscure;
  final TextInputType textInputType;
  final Function(String) onChanged;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldSetter<String> onSaved;
  final String initialValue;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: textInputType,
      cursorColor: Colors.black,
      obscureText: obscure,
      style: TextStyle(fontSize: 20),
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
      enabled: enabled,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        prefixIcon: prefix,
        suffixIcon: suffix,
        hintText: hint,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),

    );
  }
}