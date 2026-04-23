import 'package:evently_app/core/custom_widget/custom_elevated_button.dart';
import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/providers/onboarding_provider.dart';
import '../../util/app_icon.dart';
import '../../util/app_image.dart';
import '../../util/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<OnboardingProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    String? dropLanguageValue = languageProvider.appLanguage;
    ThemeMode? dropThemeValue = themeProvider.appTheme;

    AppSize.size(context);
    final List<Map<String, String>> onboardingData = [
      {
        "title":AppLocalizations.of(context)!.intro1Title,
        "desc": AppLocalizations.of(context)!.intro1Description,
        "image": AppImage.intro1,
      },
      {
        "title":AppLocalizations.of(context)!.intro2Title,
        "desc": AppLocalizations.of(context)!.intro2Description,
        "image": AppImage.intro2,
      },
      {
        "title":AppLocalizations.of(context)!.intro3Title,
        "desc": AppLocalizations.of(context)!.intro3Description,
        "image": AppImage.intro3,
      },
      {
        "title":AppLocalizations.of(context)!.intro4Title,
        "desc": AppLocalizations.of(context)!.intro4Description,
        "image": AppImage.intro4,
      },
    ];


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pro.currentIndex > 0
                  //Todo : 375  *  812
                      ? SizedBox(height: AppSize.height * 0.03,width: AppSize.width * 0.08,
                        child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: themeProvider.isLight()?AppColorLight.white:AppColorDark.inputs,
                    side: BorderSide(
                   color: Theme.of(context).colorScheme.primaryFixed)),
                       onPressed:()=>pro.previousPage(),
                     icon: Icon( size: 20,
                      Icons.arrow_back_ios,color: themeProvider.isLight()?AppColorLight.mainColor:AppColorDark.white,)),
                      )
                      : SizedBox(width: AppSize.width * 0.10),
                  Image.asset(AppIcon.evently, height: AppSize.height * 0.04,color: themeProvider.isLight()? AppColorLight.mainColor:AppColorDark.mainColor,),
                  pro.currentIndex < onboardingData.length - 1
                      ? SizedBox(height:AppSize.height * 0.03,width: AppSize.width * 0.16,
                        child: IconButton(
                        style: IconButton.styleFrom(
                        backgroundColor: themeProvider.isLight()?AppColorLight.white:AppColorDark.inputs,
                        side: BorderSide(
                        color: Theme.of(context).colorScheme.primaryFixed)),
                        onPressed: () async {
                          await pro.completeOnboarding();
                          Navigator.pushReplacementNamed(context, AppRoutes.signUpScreenRoute);
                        },
                        icon: Text(AppLocalizations.of(context)!.skipButton,style: themeProvider.isLight()? AppStyleLight.smb14MainColor:AppStyleDark.smb14White,)),
                      )
                      :  SizedBox(width: AppSize.width * 0.10),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: pro.pageController,
                onPageChanged: pro.updateIndex,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppSize.width * 0.06),
                    child: Column(crossAxisAlignment: .start,
                      children: [
                        const Spacer(),
                        Center(
                          child: SvgPicture.asset(onboardingData[index]['image']!,
                            colorFilter: ColorFilter.mode(themeProvider.isLight()? Color(0xFF1A237E) : Colors.white,
                                .srcIn),),
                        ),
                        const Spacer(),
                        Text(
                          onboardingData[index]['title']!,
                          textAlign: TextAlign.start,
                          style:themeProvider.isLight()? AppStyleLight.smb20MainText :AppStyleDark.smb20White,
                        ),

                        Text(
                          onboardingData[index]['desc']!,
                          textAlign: TextAlign.start,
                          style:themeProvider.isLight()? AppStyleLight.reg16SecText :AppStyleDark.reg16SecText,
                        ),
                         SizedBox(height: AppSize.height * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingData.length,
                                (i) => Container(
                              margin:  EdgeInsets.symmetric(horizontal: AppSize.width * 0.01),
                              width: pro.currentIndex == i ? 25 : 10,
                              height: AppSize.height * 0.009,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: pro.currentIndex == i ? AppColorLight.mainColor : AppColorDark.mainColor,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (index == 0) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text("Language", style: themeProvider.isLight()?AppStyleLight.med18MainColor:AppStyleDark.med18White),
                              DropdownButton(dropdownColor:themeProvider.isLight()?AppColorLight.white:AppColorDark.inputs,
                                underline: Divider(color: Colors.transparent),
                                value: dropLanguageValue,
                                icon: Icon(Icons.arrow_drop_down_circle_outlined,size: 24,),
                                style: themeProvider.isLight()
                                    ? AppStyleLight.med16MainText
                                    : AppStyleDark.med16White,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'en',
                                    child: Text(AppLocalizations.of(context)!.englishButton),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'ar',
                                    child: Text(AppLocalizations.of(context)!.arabicButton),
                                  ),
                                ],
                                onChanged: (String? value) {
                                  dropLanguageValue = value;
                                  languageProvider.changeLanguage(value!);
                                },
                              )
                            ],
                          ),
                           SizedBox(height: AppSize.height *0.01 ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text("Theme", style: themeProvider.isLight()?AppStyleLight.med18MainColor:AppStyleDark.med18White),
                              DropdownButton(dropdownColor:themeProvider.isLight()?AppColorLight.white:AppColorDark.inputs,
                                underline: Divider(color: Colors.transparent),
                                value: themeProvider.appTheme,
                                icon: Icon(Icons.arrow_drop_down_circle_outlined,size: 24,),
                                style: themeProvider.isLight()
                                    ? AppStyleLight.med16MainText
                                    : AppStyleDark.med16White,
                                items: [
                                  DropdownMenuItem<ThemeMode>(
                                    value:ThemeMode.light,
                                    child: Text(AppLocalizations.of(context)!.lightModeText),
                                  ),
                                  DropdownMenuItem<ThemeMode>(
                                    value: ThemeMode.dark,
                                    child: Text(AppLocalizations.of(context)!.darkModeText),
                                  ),
                                ],
                                onChanged: (ThemeMode ? value) {
                                  dropThemeValue = value;
                                  themeProvider.changeTheme(value!);
                                },
                              ),                            ],
                          ),
                        ],
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: AppSize.height*0.06,
                child: CustomElevatedButton(appLocalText:pro.currentIndex == 0
                    ? AppLocalizations.of(context)!.letsStartButton
                    : (pro.currentIndex == onboardingData.length - 1 ? AppLocalizations.of(context)!.getStartedButton : AppLocalizations.of(context)!.nextButton),
                    onTap:  () async {
                      if (pro.currentIndex == onboardingData.length - 1) {
                        await pro.completeOnboarding();
                        Navigator.pushReplacementNamed(context, AppRoutes.loginScreenRoute);
                      } else {
                        pro.nextPage();
                      }
                    },
                    switchButtonStyle: true)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
