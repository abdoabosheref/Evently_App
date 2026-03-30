import 'package:evently_app/core/providers/language_provider.dart';
import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/ui/fav_tab/fav_tab.dart';
import 'package:evently_app/ui/home_screen/home_screen.dart';
import 'package:evently_app/ui/home_screen/home_screen_provider/home_screen_provider.dart';
import 'package:evently_app/ui/home_tab/home_tab.dart';
import 'package:evently_app/ui/profile_tab/profile_tab.dart';
import 'package:evently_app/ui/on_boarding/on_boarding.dart';
import 'package:evently_app/util/app_routes.dart';
import 'package:evently_app/util/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LanguageProvider()),
   ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context)=> HomeScreenProvider())
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,

      initialRoute: AppRoutes.homeScreenRoute,
      routes:{
        AppRoutes.profileTabRoute :(context)=> ProfileTab(),
        AppRoutes.onBoardingRoute :(context)=> OnBoarding(),
        AppRoutes.homeTabRoute :(context)=> HomeTab(),
        AppRoutes.homeScreenRoute :(context) =>HomeScreen(),
        AppRoutes.favTabRoute :(context)=> FavTab(),


      },
    );
  }
}
