import 'package:evently_app/core/providers/language_provider.dart';
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
    String? dropValue = languageProvider.appLanguage;
    return Scaffold(
      body: Center(
        child: Container(
          child: ListTile(
            title: Text(AppLocalizations.of(context)!.languageText),
            trailing: DropdownButton(
              underline: Divider(color: Colors.transparent),
              value: dropValue,
              icon: Icon(Icons.arrow_drop_down_circle_outlined),
              style: AppStyleLight.med14MainText,
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
                dropValue = value;
                languageProvider.changeLanguage(value!);
              },
            ),
          ),
        ),
      ),
    );
  }
}
