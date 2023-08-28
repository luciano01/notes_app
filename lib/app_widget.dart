import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_schemes.dart';
import 'core/core.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      title: 'Notes App',
      getPages: AppPages.routes,
      initialRoute: AppRoutes.home,
      unknownRoute: AppPages.routes.first,
    );
  }
}
