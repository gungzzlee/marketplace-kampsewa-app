import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/layouts/layout_onboarding.dart';
import 'package:project_camp_sewa/screens/screen_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String? token;
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? ambilToken = prefs.getString('token');
    if (ambilToken != null) {
      token = ambilToken;
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        // Navigator.of(context).pushReplacement(
        //   PageTransition(
        //       type: PageTransitionType.rightToLeft,
        //       child: const OnboardLayout(),
        //       reverseDuration: const Duration(seconds: 2)),
        // );
        Get.off(
          () => token != null ? const ScreenDashboard() : const OnboardLayout(),
          transition: Transition.rightToLeft,
          duration: const Duration(seconds: 2),
        );
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-splash-screen.png"),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: 250,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo-camp-sewa.png")),
                ),
              ),
            ),
          ),
          Text(
            "DEVELOP BY :",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 25),
            child: Text(
              "TEAM PRODUKTIF4",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    ));
  }
}
