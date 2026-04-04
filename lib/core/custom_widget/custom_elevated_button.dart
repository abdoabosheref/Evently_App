import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:evently_app/util/app_routes.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../util/app_style_light_dark.dart';

class CustomElevatedButton extends StatelessWidget {
   CustomElevatedButton({super.key,required this.appLocalText ,
     required this.onTap,this.svgLeftIcon,required this.switchButtonStyle});
 Widget ? svgLeftIcon  ;
 String appLocalText ;
 VoidCallback onTap ;
 bool  switchButtonStyle = false  ;

  @override
  Widget build(BuildContext context) {

    var themeProvider =Provider.of<ThemeProvider>(context);
    return SizedBox(height: AppSize.height*0.059,
      child: ElevatedButton(
        style: switchButtonStyle
            ? Theme.of(context).elevatedButtonTheme.style
            : ElevatedButton.styleFrom(
      side: BorderSide(color: themeProvider.isLight()
          ?AppColorLight.stroke
          :AppColorDark.stroke,),
      textStyle:themeProvider.isLight()? AppStyleLight.med18MainColor : AppStyleDark.med18MainColor,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: themeProvider.isLight()?AppColorLight.mainColor:AppColorDark.white),

        onPressed: onTap,
          child: Row(mainAxisAlignment: .center,spacing:AppSize.width*0.04,
            children: [
              ?svgLeftIcon ,
               Text(appLocalText),
            ],
          ),
            ),
    );
  }
}
