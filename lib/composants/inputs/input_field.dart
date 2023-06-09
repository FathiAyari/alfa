import 'package:flutter/material.dart';
import 'package:flutter_application_1/dimensions/dimensions.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const InputField(
      {Key? key,
      required this.label,
      required this.textInputType,
      required this.controller,
      this.prefixWidget,
      this.suffixIcon,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.001, horizontal: Constants.screenWidth * 0.02),
      child: SizedBox(
        height: Constants.screenHeight * 0.1,
        child: TextFormField(
          onChanged: (value) => onChanged != null ? onChanged!(value) : null,
          style: TextStyle(fontSize: 18),
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Champ obligatoire";
            } else if (label == "Email") {
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
              if (!emailValid) {
                return " Invalid email format";
              }
            } else if (textInputType == TextInputType.visiblePassword && controller.text.length < 6) {
              return "Password should be longer than 8";
            }
          },
          keyboardType: textInputType,
          cursorColor: Colors.black,
          obscureText: textInputType == TextInputType.visiblePassword ? true : false,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            prefixIcon: prefixWidget,
            suffixIcon: suffixIcon,
            hintText: label,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.indigo.withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.indigo,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
