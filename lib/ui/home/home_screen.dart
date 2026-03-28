
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../util/app_size.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.size(context);

    return Scaffold(
      appBar: AppBar( title: Text(AppLocalizations.of(context)!.welcomeBack),),
    );


}
}
