import 'package:evently_app/core/providers/language_provider.dart';
import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../util/app_size.dart';
import '../../util/app_style_light_dark.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.size(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    String? dropLanguageValue = languageProvider.appLanguage;
    ThemeMode? dropThemeValue = themeProvider.appTheme;
    return Scaffold(


    );
  }
}
// Container(
//   child: ListTile(
//     title: Text(AppLocalizations.of(context)!.languageText),
//     trailing: DropdownButton(
//       underline: Divider(color: Colors.transparent),
//       value: dropLanguageValue,
//       icon: Icon(Icons.arrow_drop_down_circle_outlined),
//       style: AppStyleLight.med14MainText,
//       items: [
//         DropdownMenuItem<String>(
//           value: 'en',
//           child: Text(AppLocalizations.of(context)!.englishButton),
//         ),
//         DropdownMenuItem<String>(
//           value: 'ar',
//           child: Text(AppLocalizations.of(context)!.arabicButton),
//         ),
//       ],
//       onChanged: (String? value) {
//         dropLanguageValue = value;
//         languageProvider.changeLanguage(value!);
//       },
//     ),
//   ),
// ),
// Container(
//   child: ListTile(
//     title: Text(AppLocalizations.of(context)!.themeText),
//     trailing: DropdownButton(
//       underline: Divider(color: Colors.transparent),
//       value: dropThemeValue,
//       icon: Icon(Icons.arrow_drop_down_circle_outlined),
//       style: AppStyleLight.med14MainText,
//       items: [
//         DropdownMenuItem<ThemeMode>(
//           value: ThemeMode.light,
//           child: Text(AppLocalizations.of(context)!.lightModeText),
//         ),
//         DropdownMenuItem<ThemeMode>(
//           value: ThemeMode.dark,
//           child: Text(AppLocalizations.of(context)!.darkModeText),
//         ),
//       ],
//       onChanged: (ThemeMode? value) {
//         dropThemeValue = value;
//         themeProvider.changeTheme(value!);
//       },
//     ),
//   ),
// ),
