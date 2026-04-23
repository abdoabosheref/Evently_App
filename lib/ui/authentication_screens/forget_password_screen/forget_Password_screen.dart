import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/custom_widget/Custom_alert_dialog.dart';
import 'package:evently_app/core/custom_widget/custom_elevated_button.dart';
import 'package:evently_app/core/custom_widget/custom_snack_bar.dart';
import 'package:evently_app/core/custom_widget/custom_text_form_field.dart';
import 'package:evently_app/core/providers/user_provider.dart';
import 'package:evently_app/fire_base_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_image.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:evently_app/util/app_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/class_model/my_user.dart';
import '../../../core/custom_widget/custom_app_bar.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../util/app_routes.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});

  var emailController = TextEditingController();
  var passWordController = TextEditingController();
  var rePassWordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          showModifiedActionButtons: false,
          onTap: () {
            Navigator.pop(context, AppRoutes.loginScreenRoute);
          },
          appLocalText: Text(AppLocalizations.of(context)!.forgotPassword),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width * 0.04),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            SizedBox(height: AppSize.height * 0.04),
            SvgPicture.asset(
              AppImage.forgetPassword,
              colorFilter: ColorFilter.mode(
                themeProvider.isLight()
                    ? AppColorLight.mainColor
                    : AppColorDark.white,
                .srcIn,
              ),
              width: AppSize.width * 0.9,
              height: AppSize.height * 0.4,
            ),
            SizedBox(height: AppSize.height * 0.04),
            CustomElevatedButton(
              appLocalText: AppLocalizations.of(context)!.resetPasswordButton,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  elevation: 0,
                  enableDrag: false,
                  isDismissible: false,
                  requestFocus: true,
                  showDragHandle: false,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColorLight.backGround,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: .min,
                            crossAxisAlignment: .end,
                            spacing: AppSize.height*0.03,
                            children: [
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.resetPasswordButton,
                                    style: AppStyleLight.med20MainText.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      size: 24,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextFormField(
                                hintText: AppLocalizations.of(
                                  context,
                                )!.emailHint,
                                controller: emailController,
                                validator:(text) =>  AppValidator.emailValidation(text!),
                              ),
                              // CustomTextFormField(
                              //   hintText: AppLocalizations.of(
                              //     context,
                              //   )!.passwordHint,
                              //   controller: passWordController,
                              //   validator:(text) =>  AppValidator.passwordValidation(text!),
                              // ),
                              // CustomTextFormField(
                              //   hintText: AppLocalizations.of(
                              //     context,
                              //   )!.confirmPasswordHint,
                              //   controller: rePassWordController,
                              //   validator:(text) => AppValidator.confirmPasswordValidation(originalPassword: passWordController.text)
                              // ),
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.validate() == true) {
                                try {
                                  await FirebaseAuth.instance.setLanguageCode("en");
                                  await FirebaseAuth.instance.sendPasswordResetEmail(
                                    email: emailController.text.trim(),);
                                  var user = MyUser.collectionName ;
                                  var userQuery = await FirebaseFirestore.instance
                                      .collection(user)
                                      .where('email', isEqualTo: emailController.text.trim())
                                      .get();
                                  if(userQuery.docs.isEmpty){
                                    CustomAlertDialog.showAlert(context: context,
                                        title: 'Reset Failed' ,
                                        content: 'email not found try again.',
                                        actions: [IconButton(onPressed: (){
                                          Navigator.pop(context);
                                          emailController.text = '';
                                        }, icon: Text('ok'))]);
                                  }else{
                                    CustomAlertDialog.showAlert(context: context,
                                        title: 'Success' ,
                                        content:"Please check your email inbox and spam folder.",
                                        actions: [IconButton(onPressed: (){
                                         Navigator.pop(context);
                                         Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
                                        }, icon: Text('ok'))]);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  print("Firebase Error: ${e.code}");
                                  CustomSnackBar.snackBarAlert(context, e.message ?? "Error occurred");
                                }
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.resetPasswordButton),
                          ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              switchButtonStyle: true,
            ),
          ],
        ),
      ),
    );
  }
}
