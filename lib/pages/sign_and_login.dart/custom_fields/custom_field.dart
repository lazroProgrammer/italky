import 'package:flutter/material.dart';

class SignField extends StatelessWidget {
  final TextEditingController controller;
  final Icon? firstIcon;
  final IconButton? secondIcon;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String? param) validator;

   const SignField({
    Key? key,
    required this.validator,
    required this.controller,
    required this.firstIcon,
    required this.hintText,
    this.obscureText=false,
    this.keyboardType,
    this.secondIcon,
  }):super(key:key);



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hintText,
                  prefixIcon: firstIcon,
                  border: const OutlineInputBorder(),
                  suffixIcon: secondIcon,
                ),
    );
  }
}