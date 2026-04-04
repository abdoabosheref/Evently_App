import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/custom_widget/custom_text_form_field.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../util/app_color_light_dark.dart';


class FavTab extends StatelessWidget {
  const FavTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: AppSize.height * 0.01),
              CustomTextFormField(
                rightIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: themeProvider.isLight()
                      ? AppColorLight.mainColor
                      : AppColorDark.white,
                ),
                hintText: AppLocalizations.of(context)!.searchHint,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  //Todo ; search or fav events
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
