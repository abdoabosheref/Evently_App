import 'package:evently_app/core/custom_widget/custom_text_form_field.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/custom_widget/custom_elevated_button.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../util/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
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
                hintText: AppLocalizations.of(context)!.nameHint,
                leftIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppIcon.user,
                    width: 24,
                    fit: .contain,
                  ),
                ),
                onChanged: (text) {
                  //Todo: email validation
                },
                validator: (text) {
                  return null;
                },
              ),
              SizedBox(height: AppSize.height * 0.01),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.emailHint,
                leftIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppIcon.sms,
                    width: 24,
                    fit: .contain,
                  ),
                ),
                onChanged: (text) {
                  //Todo: password validation
                },
                validator: (text) {
                  return null;
                },
              ),
              SizedBox(height: AppSize.height * 0.01),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.passwordHint,
                leftIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppIcon.lock,
                    width: 24,
                    fit: .contain,
                  ),
                ),
                rightIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppIcon.eye,
                    width: 24,
                    fit: .contain,
                  ),
                ),
                onChanged: (text) {
                  //Todo: password validation
                },
                validator: (text) {
                  return null;
                },
              ),
              SizedBox(height: AppSize.height * 0.01),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                leftIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppIcon.lock,
                    width: 24,
                    fit: .contain,
                  ),
                ),
                rightIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppIcon.eye,
                    width: 24,
                    fit: .contain,
                  ),
                ),
                onChanged: (text) {
                  //Todo: password validation
                },
                validator: (text) {
                  return null;
                },
              ),
              SizedBox(height: AppSize.height * 0.06),
              CustomElevatedButton(
                switchButtonStyle: true,
                appLocalText: AppLocalizations.of(context)!.signupButton,
                onTap: () {
                  //todo: navigate to Home screen
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
                  //todo: navigate to Home screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
