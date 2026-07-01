import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/views/signup_view.dart';
class AppAuthButton extends StatelessWidget {
  final String buttonName;
  const AppAuthButton({super.key, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Get.to(SignupView());
    },
        style:ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(350, 60),), // width, height
        child: Text(buttonName,style: AppTextStyles.labelLarge,));
  }
}
