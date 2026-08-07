import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/screens/splash_screen.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF2F2828),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Marketplace KampSewa Indonesia",
        home: SplashScreen());
  }
}
