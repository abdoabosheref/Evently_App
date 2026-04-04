import 'package:evently_app/core/providers/language_provider.dart';
import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../util/app_size.dart';
import '../../../util/app_style_light_dark.dart';


class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    AppSize.size(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    String? dropLanguageValue = languageProvider.appLanguage;
    ThemeMode? dropThemeValue = themeProvider.appTheme;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppSize.width*0.04),
          child: Column(spacing: AppSize.height*0.039,
            children: [
              ClipRect(child: SvgPicture.asset(AppIcon.user, width:AppSize.width*0.27)),
              Column(spacing:AppSize.height*0.004,
                children: [
                Text(
                  'Abdo Mohamed',
                  style: themeProvider.isLight()
                      ? AppStyleLight.smb20MainText
                      : AppStyleDark.smb20White,
                ),
                Text(
                  'abdoabosheref@gmail.com',
                  style: themeProvider.isLight()
                      ? AppStyleLight.reg14SecText
                      : AppStyleDark.reg14SecText,
                ),
              ],),
              Column(spacing: AppSize.height*0.019,
                children: [
                Container(
                  width: AppSize.width * 0.9,
                  height: AppSize.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: BoxBorder.all(
                      color: themeProvider.isLight()
                          ? AppColorLight.white
                          : AppColorDark.mainColor,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.languageText,
                      style: themeProvider.isLight()
                          ? AppStyleLight.med16MainText
                          : AppStyleDark.med16White,
                    ),
                    trailing: DropdownButton(dropdownColor:themeProvider.isLight()?AppColorLight.white:AppColorDark.inputs,
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
                    ),
                  ),
                ),
                Container(
                  width: AppSize.width * 0.9,
                  height: AppSize.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: BoxBorder.all(
                      color: themeProvider.isLight()
                          ? AppColorLight.white
                          : AppColorDark.mainColor,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer
                  ),
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.themeText,
                      style: themeProvider.isLight()
                          ? AppStyleLight.med16MainText
                          : AppStyleDark.med16White,
                    ),
                    trailing: DropdownButton(dropdownColor:themeProvider.isLight()?AppColorLight.white:AppColorDark.inputs,
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
                    ),
                  ),
                ),
                Container(
                  width: AppSize.width * 0.9,
                  height: AppSize.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: BoxBorder.all(
                      color: themeProvider.isLight()
                          ? AppColorLight.white
                          : AppColorDark.mainColor,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: ListTile(

                    title: Text(
                      AppLocalizations.of(context)!.logoutText,
                      style: themeProvider.isLight()
                          ? AppStyleLight.med16MainText
                          : AppStyleDark.med16White,
                    ),
                    trailing: IconButton(onPressed: (){}, icon: SvgPicture.asset(AppIcon.logout,width: 24,)),
                  ),
                ),
              ],)




            ],
          ),
        ),
      ),
    );
  }

  }


