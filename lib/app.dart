import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/localization/messages.dart';



import 'core/constants/app_constants.dart';
import 'core/routes/route_helper.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final Map<String, dynamic>? notificationData;

  const MyApp({
    super.key,
    required this.languages,
    this.notificationData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return SafeArea(
          top: false,
          child: GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            theme: themeController.darkTheme ? darkTheme : lightTheme,
            locale: localizeController.locale,
            initialRoute: RouteHelper.getSplashRoute(
              notificationData: notificationData,
            ),
            getPages: RouteHelper.routes,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(
              AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode,
            ),
            defaultTransition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(0.95),
                ),
                child: child!,
              );
            },
          ),
        );
      });
    });
  }
}