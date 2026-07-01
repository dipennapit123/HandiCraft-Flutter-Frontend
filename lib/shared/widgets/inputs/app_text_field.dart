import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimesnions.dart';
class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool? obscureText;
  // final IconData? prefixIcon;
  final IconData? suffixIcon;
  // final String? Function(String?)? validator;
  const AppTextField({super.key, required this.hintText, this.controller, required this.keyboardType,  this.obscureText, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
        decoration: InputDecoration(
          suffixIcon: Icon(suffixIcon),
          contentPadding: EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 18,
          ),
          hintText: hintText,
// label: Text("Email"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            borderSide: BorderSide(
              color: AppColors.border,
            ),
          ),
        ),
         keyboardType: keyboardType,
        obscureText:obscureText??false,
//         validator: (value){
//           if (value!.isEmpty)
//           {
//             return "Enter Valid email";
//           }
//           else { return null;}
//         },
      );
  }
}
