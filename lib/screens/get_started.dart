import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  void getSystemBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFBDBDBD),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    getSystemBarTheme();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://i.ibb.co/vYZ32Xf/pexels-paul-jousseau-14918484.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sewa Alat\nCamping.",
                    style: AppColors.fontStyle(fontSize: 44,
                        color: Colors.white,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            blurRadius: 10,
                          ),
                        ],
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Sewa alat camping seluruh wilayah murah dan berkualitas, pergi ke tempat wisata tujuan dan hilangkan stress.",
                    style: AppColors.fontStyle(color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        const Shadow(
                          color: Colors.black,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // const ButtonSwipeRight(
                  //   tujuan: LoginScreen(),
                  //   title: "Mulai Sekarang!",
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
