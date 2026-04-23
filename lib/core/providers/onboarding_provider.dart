import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  // المتحكم في حركة الصفحات
  final PageController pageController = PageController();

  // الفهرس الحالي للصفحة المعروضة
  int currentIndex = 0;

  // دالة لتحديث الفهرس عند تغيير الصفحة (سواء بالسحب أو بالأزرار)
  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  // الانتقال للصفحة التالية مع حركة انسيابية
  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // الرجوع للصفحة السابقة
  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // حفظ حالة إتمام الـ Onboarding في ذاكرة الجهاز
  // يتم استدعاؤها عند الضغط على زر "Finish" أو "Get Started"
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    // ملاحظة: لا نحتاج لعمل notifyListeners هنا لأننا سننتقل لشاشة أخرى فوراً
  }

  // دوال إضافية إذا كنت تريد تغيير اللغة والثيم من داخل هذا البروفايدر مباشرة
  // (يفضل استخدام LanguageProvider و ThemeProvider منفصلين كما فعلنا سابقاً)

  Future<void> saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
  }

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  @override
  void dispose() {
    // إغلاق الـ controller للحفاظ على موارد الذاكرة
    pageController.dispose();
    super.dispose();
  }
}