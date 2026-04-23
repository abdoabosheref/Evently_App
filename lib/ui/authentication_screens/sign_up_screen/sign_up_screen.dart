import 'package:evently_app/core/class_model/my_user.dart';
import 'package:evently_app/core/custom_widget/Custom_alert_dialog.dart';
import 'package:evently_app/core/custom_widget/custom_snack_bar.dart';
import 'package:evently_app/core/custom_widget/custom_text_form_field.dart';
import 'package:evently_app/fire_base_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/custom_widget/custom_elevated_button.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../util/app_routes.dart';
import '../../../util/app_validator.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscureText = true ;
  var nameController = TextEditingController(text: 'abdo');
  var emailController = TextEditingController(text: 'abdo@gmail.com');
  var passwordController = TextEditingController(text: '371998442540aA*');
  var rePasswordController = TextEditingController(text: '371998442540aA*');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
     emailController.dispose();
     passwordController.dispose();
     rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Image.asset(AppIcon.evently),
                  SizedBox(height: AppSize.height * 0.05),
              
                  Text(
                    AppLocalizations.of(context)!.createAccountTitle,
                    style: themeProvider.isLight()
                        ? AppStyleLight.smb24MainColor
                        : AppStyleDark.smb24White,
                  ),
                  SizedBox(height: AppSize.height * 0.02),
                  CustomTextFormField(
                    keyboardType: TextInputType.name,
                    hintText: AppLocalizations.of(context)!.nameHint,
                    leftIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppIcon.user,
                        width: 24,
                        fit: .contain,
                      ),
                    ),
                    controller: nameController,
                    validator: (text) {
                      return AppValidator.nameValidation(text!);
                    },
                  ),
                  SizedBox(height: AppSize.height * 0.01),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: AppLocalizations.of(context)!.emailHint,
                    leftIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppIcon.sms,
                        width: 24,
                        fit: .contain,
                      ),
                    ),
                    controller: emailController,
                    validator: (text) {
                      return AppValidator.emailValidation(text!);
                    },
                  ),
                  SizedBox(height: AppSize.height * 0.01),
                  CustomTextFormField(hintText:AppLocalizations.of(context)!.passwordHint,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      rightIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(AppIcon.eye,width: 24,fit: .contain,),
                        ),
                      ),
                      leftIcon: Padding(
                        padding: const EdgeInsets.all( 10.0),
                        child: SvgPicture.asset(AppIcon.lock,width: 24,fit: .contain,),
                      ),
                      controller: passwordController,
                      validator: (text) {
                        return AppValidator.passwordValidation(text!);
              
                      }
              
                  ),
                  SizedBox(height: AppSize.height * 0.01),
                  CustomTextFormField(hintText:AppLocalizations.of(context)!.confirmPasswordHint,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      rightIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
              
                        },
              
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(AppIcon.eye,width: 24,fit: .contain,),
                        ),
                      ),
                      leftIcon: Padding(
                        padding: const EdgeInsets.all( 10.0),
                        child: SvgPicture.asset(AppIcon.lock,width: 24,fit: .contain,),
                      ),
                      controller: rePasswordController,
                      validator: (text) {
                    return AppValidator.confirmPasswordValidation(text: text,
                        originalPassword: passwordController.text);
              
                      }
                      ),
                  SizedBox(height: AppSize.height * 0.06),
                  CustomElevatedButton(
                    switchButtonStyle: true,
                    appLocalText: AppLocalizations.of(context)!.signupButton,
                    onTap: () async {
                      if(formKey.currentState!.validate()){
                        CustomAlertDialog.showAlert(context: context,
                            title: 'Sign-up',
                            content: 'Waiting..',
                            actions: []);

                        try {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          // await credential.user!.updateDisplayName(nameController.text);
                          MyUser user = MyUser(
                              id: credential.user?.uid ??'',
                              name: nameController.text,
                              email: emailController.text);
                          await FireBaseUtils.addUserToFireStore(user);

                         if(mounted){
                           Navigator.pop(context);
                           CustomAlertDialog.showAlert(context: context,
                               title: 'Sign-up',
                               content: 'Success',
                               actions: [IconButton(onPressed: () {
                                 Navigator.pop(context);
                                 Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
                               }, icon: Text('ok'))]);
                         }
                        } on FirebaseAuthException catch (e) {
                          if (mounted) Navigator.pop(context);
                          if (e.code == 'weak-password') {
                            CustomAlertDialog.showAlert(context: context,
                                title: 'Fail',
                                content: 'The password provided is too weak.',
                                actions: [IconButton(onPressed: () {
                                  Navigator.pop(context);
                                }, icon: Text('ok'))]);
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            CustomAlertDialog.showAlert(context: context,
                                title:'Fail' ,
                                content:'The account already exists for that email.',
                                actions: [IconButton(onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
                                }, icon: Text('ok'))]);

                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                  SizedBox(height: AppSize.height * 0.05),
                  Row(
                    mainAxisAlignment: .center,
                    spacing: 1,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAccount,
                        style: themeProvider.isLight()
                            ? AppStyleLight.smb14SecText
                            : AppStyleDark.smb14SecText,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.loginScreenRoute);
                        },
                        child: Text(AppLocalizations.of(context)!.loginButton),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.height * 0.03),
                  Row(
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(child: Divider(endIndent: 16)),
                      Text(
                        AppLocalizations.of(context)!.or,
                        style: themeProvider.isLight()
                            ? AppStyleLight.med16MainColor
                            : AppStyleDark.med16MainColor,
                      ),
                      Expanded(child: Divider(indent: 16)),
                    ],
                  ),
                  SizedBox(height: AppSize.height * 0.02),
                  CustomElevatedButton(
                    switchButtonStyle: false,
                    svgLeftIcon: SvgPicture.asset(
                      AppIcon.google,
                      colorFilter: null,
                      width: AppSize.width * 0.03,
                      height: AppSize.height * 0.03,
                    ),
                    appLocalText: AppLocalizations.of(context)!.signupWithGoogle,
                    onTap: () {
                      //todo: navigate to login screen after google sign up

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
