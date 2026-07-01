import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/features/auth/views/login_view.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimesnions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/buttons/app_auth_button.dart';
import '../../../shared/widgets/inputs/app_text_field.dart';
class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  //formkey
  final formkeySignup=GlobalKey<FormState>();

  TextEditingController fullName=TextEditingController();

  TextEditingController email=TextEditingController();

  TextEditingController password=TextEditingController();

  TextEditingController confirmPassword=TextEditingController();

  bool isChecked = false;
 // for checkbox
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("KalaKosh",style: AppTextStyles.displayLarge,),
            Gap(AppDimensions.lg),
            Text("Create Account",style: AppTextStyles.heading2,),
            Gap(AppDimensions.sm),
            Text("Enter your details to start your \n journey into Himalayan artistry.",style: AppTextStyles.bodyLarge,textAlign: TextAlign.center,),
            Gap(AppDimensions.sm),


            // Create a SignupScreen TextForm Field
            Padding(
              padding: const EdgeInsets.all(AppDimensions.screenPaddingV),
              child: Form(
                  key: formkeySignup,
                  child: Column(
                    children: [
                      // Full Name Field
                      Row(
                        children: [
                          Text("Full Name",style: AppTextStyles.labelMedium.copyWith(fontSize: 16),),
                        ],
                      ),
                      Gap(AppDimensions.sm),
                      AppTextField(hintText: 'Arjun Khanal', keyboardType:TextInputType.text ,controller: fullName,),
                      Gap(AppDimensions.md),

                      // Email Field
                      Row(
                        children: [
                          Text("Email Address",style: AppTextStyles.labelMedium.copyWith(fontSize: 16),),
                        ],
                      ),
                      Gap(AppDimensions.sm),
                      AppTextField(hintText: 'namaste@kalakosh.com', keyboardType:TextInputType.emailAddress ,controller: email,),
                      Gap(AppDimensions.md),

                      // Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Password",style: AppTextStyles.labelMedium.copyWith(fontSize: 16),),
                        ],
                      ),
                      Gap(AppDimensions.sm),
                      AppTextField(hintText: '*********', keyboardType:TextInputType.visiblePassword , controller: password,suffixIcon: Icons.remove_red_eye_outlined,),
                      Gap(AppDimensions.md),

                      // Confirm Password Field
                      // Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Confirm Password",style: AppTextStyles.labelMedium.copyWith(fontSize: 16),),
                        ],
                      ),
                      Gap(AppDimensions.sm),
                      AppTextField(hintText: '*********', keyboardType:TextInputType.visiblePassword , obscureText: true,controller: confirmPassword,suffixIcon: Icons.remove_red_eye_outlined,),
                      Gap(AppDimensions.md),

                      // Check Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(value: isChecked, onChanged: (value){
                            setState(() {
                              isChecked=value!;
                            });
                          }),
                          RichText(text: TextSpan(children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: AppTextStyles.bodySmall
                            ),
                            TextSpan(
                                text: "Terms of Service ",
                                style: AppTextStyles.bodySmall.copyWith(color:AppColors.primary)
                                ),
                            TextSpan(
                                text: "and ",
                                style: AppTextStyles.bodySmall
                            ),
                            TextSpan(
                                text: "Privacy Policy",
                                style: AppTextStyles.bodySmall.copyWith(color:AppColors.primary)
                            )

                          ])),
                        ],
                      ),
                      Gap(AppDimensions.sm),

                      // Button
                      AppAuthButton(buttonName: "Create Your Account"),

                      //Already have an account
                      Gap(AppDimensions.xl),
                      RichText(text: TextSpan(children: [
                        TextSpan(
                            text: "Already have an account? ",
                            style: AppTextStyles.bodySmall
                        ),
                        TextSpan(
                            text: "Login",
                            style: AppTextStyles.link,
                            recognizer: TapGestureRecognizer()..onTap=((){
                              Get.to(LoginView());
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
