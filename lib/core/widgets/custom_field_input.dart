import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  String hintText;
  TextInputType inputType;
  final TextEditingController controller;

  final bool isPassword;
  final IconData? prefixIcon;

  CustomInputField({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
  });

  /// Optional validation function that returns an error string or null
  final String? Function(String?)? validator;

  @override
  State<StatefulWidget> createState() => _CustomInputFieldState();
}


class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,

      maxLines: 1,
      onChanged: (_) => Form.of(context).validate(),
      validator: widget.validator,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white),
      style: const TextStyle(color: Colors.black),
    );
  }
}
