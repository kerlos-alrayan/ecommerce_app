import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    this.onSaved,
    this.onChange,
    this.controller,
    this.borderColor = Colors.grey,
    required this.labelText,
    this.prefixIcon,
    this.prefixIconColor,
    this.validator,
    this.isPassword = false, this.suffixIcon, required this.textInputAction,
  }); // Added borderColor parameter
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChange;
  final Color borderColor; // Added borderColor property
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputAction textInputAction;

  @override
  State<CustomTextFormField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final defaultPadding = const EdgeInsets.symmetric(horizontal: 0);
    return Padding(
      padding: defaultPadding,
      child: TextFormField(
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassword ? _obscureText : false,
        controller: widget.controller,
        onChanged: widget.onChange,
        onSaved: widget.onSaved,
        validator: widget.validator,
        cursorColor: Colors.black,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: Colors.white,
          labelText: widget.labelText, // Hint integrated into the border
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Color(0xff9098B1)),
          border: buildBorder(widget.borderColor),
          enabledBorder: buildBorder(widget.borderColor),
          focusedBorder: buildBorder(const Color(0xFF478ecc)),
          prefixIcon: Icon(widget.prefixIcon, color: Color(0xff9098B1)),
          prefixIconColor: widget.prefixIconColor,
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Color(0xffEBF0FF)), // Use color parameter
    );
  }
}
