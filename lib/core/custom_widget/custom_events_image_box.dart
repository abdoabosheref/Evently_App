import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../util/app_size.dart';

class CustomEventsImageBox extends StatelessWidget {
  var  image ;


   CustomEventsImageBox({super.key, this.image,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Container(height: AppSize.height*0.23,
      decoration: BoxDecoration(
          image:DecorationImage(
              image: AssetImage(image) ,),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.primaryFixed),
          color: Theme.of(context).colorScheme.primaryContainer),);
  }
}
