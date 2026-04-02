import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_icon.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final TextInputType? keyboardType;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String hintText;


   CustomTextFormField({super.key,required this.hintText, this.validator,
   required this.onChanged,this.keyboardType,this.leftIcon,this.rightIcon});

  @override
  Widget build(BuildContext context) {
    var themeProvider= Provider.of<ThemeProvider>(context);
    return TextFormField(

      validator: validator,
      onChanged: onChanged,

      style: themeProvider.isLight()
          ?AppStyleLight.reg14MainText : AppStyleDark.reg14white,
      textAlign: .start,
      cursorColor: themeProvider.isLight()
          ?AppColorLight.mainColor : AppColorDark.white,
      keyboardType:keyboardType ,
      cursorErrorColor: AppColorLight.red,
      cursorHeight: 30,
      cursorWidth: 2,
      decoration:
      InputDecoration(
        filled: true,
        fillColor: themeProvider.isLight()
            ?AppColorLight.white:AppColorDark.inputs,
        suffixIcon: rightIcon,
        prefixIcon: leftIcon,
        hintText: hintText,
        hintStyle:themeProvider.isLight()
            ?AppStyleLight.reg14SecText : AppStyleDark.reg14SecText ,
        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 13),
        disabledBorder: builtOIB(themeProvider),
        enabledBorder: builtOIB(themeProvider),
        focusedBorder:builtOIB(themeProvider),
        border:builtOIB(themeProvider),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColorLight.red),
          borderRadius: BorderRadius.circular(8),
        ),


      ),
    );
  }
  OutlineInputBorder builtOIB (ThemeProvider themeProvider){
    return OutlineInputBorder(
      borderSide: BorderSide(color: themeProvider.isLight()? AppColorLight.stroke:AppColorDark.stroke,),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
