import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Constant/colors.dart';
import 'Constant/font_family.dart';
import 'Navigation/nevigation.dart';
import 'Navigation/routername.dart';

Locale? initialLocale;

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.white100Color,
            ),
            fontFamily: Appfonts.family2Regular,
            useMaterial3: true),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        locale: initialLocale,
        translations: null,
        fallbackLocale: const Locale('en', 'US'),
        initialRoute: RouterName.genrePreferencesWrapper,
        debugShowCheckedModeBanner: false,
        getPages: Pages.pages(),
      );
    });
  }
}
