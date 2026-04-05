import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../util/app_color_light_dark.dart';
import '../../util/app_icon.dart';
import '../../util/app_routes.dart';
import '../../util/app_size.dart';

class CustomAppBar extends StatelessWidget {
  VoidCallback onTap ;
  VoidCallback? onTapEdit ;
  VoidCallback? onTapDelete ;
  String appLocalText ;
  bool showModifiedActionButtons ;
   CustomAppBar({super.key,required this.onTap,required this.appLocalText,
     this.onTapDelete,this.onTapEdit,required this.showModifiedActionButtons
   });


  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return  AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          AppIcon.arrowLift,
          width: AppSize.width * 0.064,
          height: AppSize.height * 0.02,
          colorFilter: ColorFilter.mode(
            themeProvider.isLight()
                ? AppColorLight.mainColor
                : AppColorDark.white,
                .srcIn,
          ),
        ),
      ),
      title: Text(appLocalText),
      actions: [

        Visibility(visible: showModifiedActionButtons  ,
          child: IconButton(onPressed:onTapEdit, icon: SvgPicture.asset(AppIcon.edit,
          colorFilter:ColorFilter.mode(themeProvider.isLight()?AppColorLight.mainColor:
          AppColorDark.mainColor, .srcIn),)),
        ),
        Visibility(visible: showModifiedActionButtons,
            child: IconButton(onPressed:onTapDelete,
                icon: SvgPicture.asset(AppIcon.trash))),


      ],
    );
  }
}
