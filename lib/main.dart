import 'package:evently_app/core/providers/language_provider.dart';
import 'package:evently_app/core/providers/theme_provider.dart';
import 'package:evently_app/ui/authentication_screens/forget_password_screen/forget_Password_screen.dart';
import 'package:evently_app/ui/authentication_screens/login_screen/login_screen.dart';
import 'package:evently_app/ui/authentication_screens/sign_up_screen/sign_up_screen.dart';
import 'package:evently_app/ui/event_screens/add_event/add_event.dart';
import 'package:evently_app/ui/event_screens/edit_event/edit_event.dart';
import 'package:evently_app/ui/event_screens/event_details/event_details.dart';
import 'package:evently_app/ui/home_screen/fav_tab/fav_tab.dart';
import 'package:evently_app/ui/home_screen/home_screen.dart';
import 'package:evently_app/core/providers/home_screen_provider.dart';
import 'package:evently_app/ui/home_screen/home_tab/home_tab.dart';
import 'package:evently_app/ui/home_screen/profile_tab/profile_tab.dart';
import 'package:evently_app/ui/on_boarding/on_boarding.dart';
import 'package:evently_app/util/app_routes.dart';
import 'package:evently_app/util/app_size.dart';
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
    AppSize.size(context);

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

      initialRoute: AppRoutes.loginScreenRoute,
      routes:{
        AppRoutes.profileTabRoute :(context)=> ProfileTab(),
        AppRoutes.onBoardingRoute :(context)=> OnBoarding(),
        AppRoutes.homeTabRoute :(context)=> HomeTab(),
        AppRoutes.homeScreenRoute :(context) =>HomeScreen(),
        AppRoutes.favTabRoute :(context)=> FavTab(),
        AppRoutes.loginScreenRoute :(context)=> LoginScreen(),
        AppRoutes.signUpScreenRoute :(context) =>SignUpScreen(),
        AppRoutes.forgetPasswordScreenRoute :(context)=> ForgetPasswordScreen(),
        AppRoutes.editEventScreenRoute :(context)=> EditEvent(),
        AppRoutes.addEventScreenRoute :(context)=> AddEvent(),
        AppRoutes.eventDetailsScreenRoute :(context)=> EventDetails(),





      },
    );
  }
}
