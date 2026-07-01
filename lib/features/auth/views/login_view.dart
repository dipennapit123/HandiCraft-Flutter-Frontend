import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/core/constants/app_colors.dart';
import 'package:handicraftmobilefrontend/core/constants/app_dimesnions.dart';
import 'package:handicraftmobilefrontend/core/constants/app_text_styles.dart';
import 'package:handicraftmobilefrontend/features/auth/views/signup_view.dart';
import 'package:handicraftmobilefrontend/shared/widgets/buttons/app_auth_button.dart';
import 'package:handicraftmobilefrontend/shared/widgets/inputs/app_text_field.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // create a key-->jasle chai help garxa identify the form(access all textfield) and help for validation , show error at the bottom of text field
  final formkeyLogin=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isChecked = false; // for checkbox

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Text("KalaKosh",style: AppTextStyles.displayLarge,),
           Gap(AppDimensions.xl),
           Text("Welcome Back",style: AppTextStyles.heading2,),
           Gap(AppDimensions.sm),
           Text("Please enter your credentials to \n access your gallery.",style: AppTextStyles.bodyLarge,textAlign: TextAlign.center,),
           Gap(AppDimensions.sm),


           // Create a LoginScreen TextForm Field
           Padding(
             padding: const EdgeInsets.all(AppDimensions.screenPaddingV),
             child: Form(
               key: formkeyLogin,
               child: Column(
                 children: [
                   // Email Field
                   Row(
                     children: [
                       Text("Email Address",style: AppTextStyles.labelMedium.copyWith(fontSize: 16),),
                     ],
                   ),
                   Gap(AppDimensions.sm),
                   AppTextField(hintText: 'namaste@kalakosh.com', keyboardType:TextInputType.emailAddress , obscureText: false,controller: email,),
                   Gap(AppDimensions.md),

                   // Password Field
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Password",style: AppTextStyles.labelMedium.copyWith(fontSize: 16),),
                       GestureDetector(child: Text("Forgot?",style: AppTextStyles.labelMedium.copyWith(fontSize: 12,color: AppColors.primary),)),
                     ],
                   ),
                   Gap(AppDimensions.sm),
                   AppTextField(hintText: '*********', keyboardType:TextInputType.emailAddress , obscureText: true,controller: password,suffixIcon: Icons.remove_red_eye_outlined,),

                   // Check Field
                   Gap(AppDimensions.sm),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Checkbox(value: isChecked, onChanged: (value){
                         setState(() {
                           isChecked=value!;
                         });
                       }),
                       Text("Keep me signed in for 30 days")
                     ],
                   ),

                   // Button
                   Gap(AppDimensions.sm),
                  AppAuthButton(buttonName: "Access Your Collection"),
                   //Don't have an account
                   Gap(AppDimensions.xl),
                   RichText(text: TextSpan(children: [
                     TextSpan(
                       text: "Don't have an account? ",
                       style: AppTextStyles.bodySmall
                     ),
                     TextSpan(
                         text: "Sign Up",
                         style: AppTextStyles.link,
                       recognizer: TapGestureRecognizer()..onTap=((){
                         Get.to(SignupView());
                       })
                     ),

                   ])),


                 ],
               )
             ),
           ),

          ],
        ),
      ),
    );
  }
}
