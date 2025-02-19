
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';




class textfield extends StatelessWidget {
  const textfield({Key? key,
    required this.mycontroller,

    required this.fieldSetter,
    required this.keyBoradtype,
    required this.obscureText,
    required this.hint,
    this.enable=true,
    required this.fieldValidator,
    this.autoFocus= false,

   required this.label,

  }) : super(key: key);
  final TextEditingController  mycontroller;

  final FormFieldSetter fieldSetter;
  final FormFieldValidator fieldValidator;
  final TextInputType keyBoradtype;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(


        controller:  mycontroller,

        onFieldSubmitted: fieldSetter,
        obscureText: obscureText,
        validator: fieldValidator,
        keyboardType:  keyBoradtype,
        enabled: enable,


        decoration: InputDecoration(
          labelText: label,
       labelStyle: TextStyle(color: Colors.white60),

       contentPadding: EdgeInsets.all(1),
          hintText: hint,
hintStyle: TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide:  BorderSide(color:  AppColors.textFieldDefaultFocus, ),
            borderRadius: BorderRadius.all(Radius.circular(8)),

          ),
            focusedBorder:  OutlineInputBorder(
        borderSide:  BorderSide(color:  AppColors.whiteColor, ),
        borderRadius: BorderRadius.all(Radius.circular(8)),

      ),
          errorBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color:  AppColors.alertColor, ),
            borderRadius: BorderRadius.all(Radius.circular(8)),

          ),
          enabledBorder:  OutlineInputBorder(
            borderSide:  BorderSide(color:  AppColors.textFieldDefaultBorderColor, ),
            borderRadius: BorderRadius.all(Radius.circular(8)),

          )
        ),
        style: TextStyle(
          color: Colors.white, // Change the text color here
          fontSize: 20,
          fontWeight: FontWeight.bold// Optional: Adjust font size
        ),
        inputFormatters: [
          // Conditionally restrict input to digits using a TextInputFormatter
          if (keyBoradtype == TextInputType.number)
            FilteringTextInputFormatter.digitsOnly, // Only digits for numeric input
        ],
      ),
    );
  }
}
