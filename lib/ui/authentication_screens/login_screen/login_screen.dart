import 'package:google_sign_in/google_sign_in.dart';
import 'package:evently_app/core/custom_widget/Custom_alert_dialog.dart';
import 'package:evently_app/core/custom_widget/custom_snack_bar.dart';
import 'package:evently_app/core/custom_widget/custom_text_form_field.dart';
import 'package:evently_app/core/providers/event_list_provider.dart';
import 'package:evently_app/core/providers/user_provider.dart';
import 'package:evently_app/fire_base_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:evently_app/util/app_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/custom_widget/custom_elevated_button.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../util/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController  =TextEditingController(text: 'abdoabosheref@gmail.com') ;

   TextEditingController passwordController  =TextEditingController(text: '371998442540aA*') ;

   GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  bool obscureText = true ;
  @override
  Widget build(BuildContext context) {


    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Image.asset(AppIcon.evently),
                  SizedBox(height: AppSize.height * 0.05),
                  Text(AppLocalizations.of(context)!.loginTitle,
                    style: themeProvider.isLight()
                        ? AppStyleLight.smb24MainColor
                        : AppStyleDark.smb24White,
                  ),
                  SizedBox(height: AppSize.height * 0.02),
                  CustomTextFormField(hintText:AppLocalizations.of(context)!.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    leftIcon: Padding(
                      padding: const EdgeInsets.all( 10),
                      child: SvgPicture.asset(AppIcon.sms,width: 24,fit: .contain,),
                    ),
                    controller: emailController,
                      validator: (text ) {
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
                  SizedBox(height: AppSize.height * 0.009),
                  Align(alignment: .centerRight,
                    child: TextButton(onPressed: (){
                      // navigate to forget password screen
                      Navigator.pushNamed(context, AppRoutes.forgetPasswordScreenRoute);
                    },
                        child:  Text(AppLocalizations.of(context)!.forgotPassword,)
                    ),),
                  SizedBox(height: AppSize.height * 0.05),
                  CustomElevatedButton(switchButtonStyle: true,
                    appLocalText:AppLocalizations.of(context)!.loginButton ,
                    onTap:  () async{
                      //todo: navigate to Home screen
                      if(formKey.currentState!.validate()){
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                         var user = await FireBaseUtils.readUserFromFireStore(credential.user?.uid??'');
                         var userProvider =Provider.of<UserProvider>(context,listen: false);
                         var eventListProvider =Provider.of<EventListProvider>(context,listen: false);
                         userProvider.updateUser(user!);
                         CustomAlertDialog.showAlert(context: context,
                             title: 'Login',
                             content: 'Login Success',
                             actions: [IconButton(onPressed:
                                 (){
                               eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id) ;
                               Navigator.pop(context);
                               Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRoute);

                             },
                                 icon: Text('ok'))]);

                        } on FirebaseAuthException catch (e) {
                          print("Firebase Error Code: ${e.code}");

                          if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
                            CustomSnackBar.snackBarAlert(context, 'Invalid email or password. Please try again.');
                          } else if (e.code == 'invalid-email') {
                            CustomSnackBar.snackBarAlert(context, 'The email address is not valid.');
                          } else {
                            CustomSnackBar.snackBarAlert(context, e.message ?? 'An error occurred.');
                          }
                        } catch (e) {
                          print(e);
                        }


                      }


                    }),
                  SizedBox(height: AppSize.height * 0.05),
                  Row(mainAxisAlignment: .center,spacing:1,
                      children: [
                        Text(AppLocalizations.of(context)!.dontHaveAccount,
                         style: themeProvider.isLight()? AppStyleLight.smb14SecText:
                         AppStyleDark.smb14SecText,),
                       TextButton(onPressed: (){
                         //todo: navigate to sign up screen
                         Navigator.pushNamed(context, AppRoutes.signUpScreenRoute);
                       },
                           child:  Text(AppLocalizations.of(context)!.signupButton,)
                            ) ],
                ),
                  SizedBox(height: AppSize.height * 0.03),
                  Row(crossAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: Divider(
                          endIndent: 16,
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.or,
                        style:themeProvider.isLight()
                            ?AppStyleLight.med16MainColor
                            :AppStyleDark.med16MainColor,
                        ),
                      Expanded(
                        child: Divider(
                          indent: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.height * 0.02),
                  CustomElevatedButton( switchButtonStyle: false,
                    svgLeftIcon: SvgPicture.asset(AppIcon.google,colorFilter: null,
                      width: AppSize.width*0.03,height:AppSize.height*0.03,),
                      appLocalText:AppLocalizations.of(context)!.loginWithGoogle ,
                      onTap:  () {
                        //todo: navigate to Home screen google auth


                        }


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
