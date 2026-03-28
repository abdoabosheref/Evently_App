import 'package:evently_app/core/providers/language_provider.dart';
import 'package:evently_app/ui/home/home_screen.dart';
import 'package:evently_app/ui/on_boarding/on_boarding.dart';
import 'package:evently_app/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => LanguageProvider(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      locale: Locale(languageProvider.appLanguage),
      title: 'Evently App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreenRoute,
      routes:{
        AppRoutes.homeScreenRoute :(context)=> HomeScreen(),
        AppRoutes.onBoardingRoute :(context)=> OnBoarding(),

      },
    );
  }
}
