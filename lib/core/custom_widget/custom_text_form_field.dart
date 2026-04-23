import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/util/app_color_light_dark.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_style_light_dark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String hintText;
  final int ? maxLines ;
  TextEditingController? controller;
  bool  obscureText  ;
  bool readOnly ;


   CustomTextFormField({super.key,required this.hintText, this.validator,
    this.onChanged,this.keyboardType,this.leftIcon,this.rightIcon,
   this.maxLines ,this.controller ,this.obscureText = false ,this.readOnly =false });

  @override
  Widget build(BuildContext context) {
    var themeProvider= Provider.of<ThemeProvider>(context);
    return TextFormField(
      maxLines: obscureText ? 1 : (maxLines ?? 1),

      validator: validator,
      onChanged: onChanged,
      controller: controller,
      style: themeProvider.isLight()
          ?AppStyleLight.reg14MainText : AppStyleDark.reg14white,
      textAlign: .start,
      cursorColor: themeProvider.isLight()
      ?AppColorLight.mainColor : AppColorDark.white,
      keyboardType:keyboardType ,
      cursorErrorColor: AppColorLight.red,
      cursorHeight: 30,
      cursorWidth: 2,
      obscureText: obscureText,
      obscuringCharacter: '*',
      readOnly: readOnly,

      decoration:
      InputDecoration(
        filled: true,
        fillColor: themeProvider.isLight()
        ?AppColorLight.white : AppColorDark.inputs,
        suffixIcon: rightIcon,
        suffixIconConstraints:BoxConstraints() ,
        prefixIcon: leftIcon,
        hintText: hintText,
        hintStyle:themeProvider.isLight()
        ?AppStyleLight.reg14SecText : AppStyleDark.reg14SecText ,
        contentPadding: EdgeInsets.symmetric(
        horizontal:AppSize.width*0.04,vertical:AppSize.height*0.01),
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
      borderSide: BorderSide(color: themeProvider.isLight()
          ?AppColorLight.stroke
          :AppColorDark.stroke,),
      borderRadius: BorderRadius.circular(16),

    );
  }
}
