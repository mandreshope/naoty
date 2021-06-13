import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:naoty/app/data/providers/api.dart';
import 'package:naoty/app/modules/splash/splash_binding.dart';
import 'package:naoty/app/modules/splash/splash_view.dart';
import 'package:naoty/app/routes/app_pages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'app/data/services/auth_service.dart';
import 'app/translations/app_translations.dart';

Future<void> main() async {
  await GetStorage.init();
  initServices();

  runApp(GetMaterialApp(
      title: 'Naoty',
      defaultTransition: Transition.topLevel,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      initialBinding: SplashBinding(),
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr', 'FR'),
        const Locale('en', 'US'), // English, no country code
      ],
      locale: Locale('fr', 'FR'),
      translationsKeys: AppTranslation.translations,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF122341,
          <int, Color>{
            50: Color(0xFFE3E5E8),
            100: Color(0xFFB8BDC6),
            200: Color(0xFF8991A0),
            300: Color(0xFF59657A),
            400: Color(0xFF36445E),
            500: Color(0xFF122341),
            600: Color(0xFF101F3B),
            700: Color(0xFF0D1A32),
            800: Color(0xFF0A152A),
            900: Color(0xFF050C1C),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      home: SplashView()));
}

/// Is a smart move to make your Services intiialize before you run the Flutter app.
/// as you can control the execution flow (maybe you need to load some Theme configuration,
/// apiKey, language defined by the User... so load SettingService before running ApiService.
/// so GetMaterialApp() doesnt have to rebuild, and takes the values directly.
void initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  Get.put<ApiClient>(ApiClient());
  Get.put<AuthService>(AuthService());
  print('All services started...');
}
