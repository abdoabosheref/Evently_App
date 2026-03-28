import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/app_color_light_dark.dart';
import '../../util/app_icon.dart';
import '../../util/app_image.dart';
import '../../util/app_style_light_dark.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
     Column(crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 24,
    children: [
      Image.asset(AppIcon.evently),
    //Todo:pageview.builder + ui modifications
    SvgPicture.asset(AppImage.intro1),
    Text(
    'Personalize Your Experience',
    style: AppStyleLight.smb20MainText,
    ),
    Text(
    'Choose your preferred theme and language '
    'to get started with a comfortable, tailored experience '
    'that suits your style.',
    style: AppStyleLight.reg16SecText,
    ),

    Row(
    spacing: 8,
    children: [
    Text('Language', style: AppStyleLight.med18MainColor),
    Spacer(),
    InkWell(
    onTap: () {},
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: AppColorLight.mainColor,
    ),
    width: 83,
    height: 32,
    child: Center(
    child: Text(
    'English',
    style: AppStyleLight.smb14White,
    ),
    ),
    ),
    ),

    InkWell(
    onTap: () {},
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: AppColorLight.white,
    ),
    width: 83,
    height: 32,
    child: Center(
    child: Text(
    'Arabic',
    style: AppStyleLight.reg14MainColor,
    ),
    ),
    ),
    ),
    ],
    ),
    Row(
    spacing: 8,
    children: [
    Text('Theme', style: AppStyleLight.med18MainColor),
    Spacer(),
    InkWell(
    onTap: () {},
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: AppColorLight.mainColor,
    ),
    width: 56,
    height: 32,
    child: SvgPicture.asset(
    AppIcon.sun,
    width: 24,
    height: 24,
    fit: BoxFit.scaleDown,
    ),
    ),
    ),

    InkWell(
    onTap: () {},
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: AppColorLight.white,
    ),
    width: 56,
    height: 32,
    child: SvgPicture.asset(
    AppIcon.moon,
    width: 24,
    height: 24,
    fit: BoxFit.scaleDown,
    ),
    ),
    ),
    ],
    ),
    SizedBox(
    width: 343,
    height: 48,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(16),
    ),
    backgroundColor: AppColorLight.mainColor,
    elevation: 0,
    ),
    child: Text('Next', style: AppStyleLight.med20White),
    onPressed: (){},
    ),
    ),
    ],
    ),
    );
  }
}
