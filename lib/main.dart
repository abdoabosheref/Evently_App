import 'package:evently_app/ui/authentication_screens/forget_password_screen/forget_Password_screen.dart';
import 'package:evently_app/ui/authentication_screens/login_screen/login_screen.dart';
import 'package:evently_app/ui/authentication_screens/sign_up_screen/sign_up_screen.dart';
import 'package:evently_app/ui/event_screens/add_event/add_event.dart';
import 'package:evently_app/ui/event_screens/edit_event/edit_event.dart';
import 'package:evently_app/ui/event_screens/event_details/event_details.dart';
import 'package:evently_app/ui/home_screen/fav_tab/fav_tab.dart';
import 'package:evently_app/ui/home_screen/home_screen.dart';
import 'package:evently_app/ui/home_screen/home_tab/home_tab.dart';
import 'package:evently_app/ui/home_screen/profile_tab/profile_tab.dart';
import 'package:evently_app/ui/on_boarding/on_boarding.dart';
import 'package:evently_app/util/app_routes.dart';
import 'package:evently_app/util/app_size.dart';
import 'package:evently_app/util/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/providers/event_list_provider.dart';
import 'core/providers/home_screen_provider.dart';
import 'core/providers/language_provider.dart';
import 'core/providers/onboarding_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/user_provider.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  // 1. تهيئة الأدوات
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  final prefs = await SharedPreferences.getInstance();


  final languageProvider = LanguageProvider();
  final themeProvider = ThemeProvider();
  final onboardingProvider = OnboardingProvider();

  await languageProvider.loadLanguage();
  await themeProvider.loadTheme();

  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: languageProvider),
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: onboardingProvider),

        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(isFirstTime: isFirstTime),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, this.isFirstTime = true});

  @override
  Widget build(BuildContext context) {
    AppSize.size(context);

    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      locale: Locale(languageProvider.appLanguage),
      title: 'Evently App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,

      initialRoute: isFirstTime ? AppRoutes.onBoardingScreenRoute : AppRoutes.loginScreenRoute,

      routes: {
        AppRoutes.profileTabRoute: (context) => ProfileTab(),
        AppRoutes.onBoardingScreenRoute: (context) => const OnboardingScreen(),
        AppRoutes.homeTabRoute: (context) => HomeTab(),
        AppRoutes.homeScreenRoute: (context) => HomeScreen(),
        AppRoutes.favTabRoute: (context) => FavTab(),
        AppRoutes.loginScreenRoute: (context) => LoginScreen(),
        AppRoutes.signUpScreenRoute: (context) => SignUpScreen(),
        AppRoutes.forgetPasswordScreenRoute: (context) => ForgetPasswordScreen(),
        AppRoutes.editEventScreenRoute: (context) => EditEvent(),
        AppRoutes.addEventScreenRoute: (context) => AddEvent(),
        AppRoutes.eventDetailsScreenRoute: (context) => EventDetails(),
      },
    );
  }
}