import 'package:evently_app/core/custom_widget/custom_elevated_button.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_image.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/custom_widget/custom_app_bar.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../util/app_routes.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(showModifiedActionButtons: false,
          onTap: (){
          Navigator.pop(context,AppRoutes.loginScreenRoute);
        },
        appLocalText: AppLocalizations.of(context)!.forgotPassword,),
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
                //Todo: reset password
              },
              switchButtonStyle: true,
            ),
          ],
        ),
      ),
    );
  }
}
