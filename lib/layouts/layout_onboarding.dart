import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/components/buttionanimation/swiperight.dart';
import 'package:project_camp_sewa/screens/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class KontenOnboarding {
  final String title;
  final String deskripsi;
  final String image;
  KontenOnboarding(
      {required this.title, required this.deskripsi, required this.image});
}

class OnboardingItems {
  List<KontenOnboarding> items = [
    KontenOnboarding(
        title: "Temukan Peralatan",
        deskripsi:
            "Pilih peralatan yang anda inginkan sebelum memulai petualangan yang menyenangkan. ",
        image: "assets/images/onboarding-img1.jpg"),
    KontenOnboarding(
        title: "Sesuaikan Kebutuhan",
        deskripsi:
            "Pilih peralatan yang sesuai dengan kebutuhan anda Selama berpetualang dialam bebas. ",
        image: "assets/images/onboarding-img2.jpg"),
    KontenOnboarding(
        title: "Pergi Berpetualang",
        deskripsi:
            "Berpetualan dengan perlatan yang memadai dan menikmati petualangan tanpa batas.",
        image: "assets/images/onboarding-img3.jpg")
  ];
}

class OnboardLayout extends StatefulWidget {
  const OnboardLayout({super.key});

  @override
  State<OnboardLayout> createState() => _OnboardLayoutState();
}

class _OnboardLayoutState extends State<OnboardLayout> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF32363F),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Mengatur radius lengkungan untuk setiap sudut
                      ),
                      side: const BorderSide(
                          color: Colors.black), // Mengatur warna outline
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.skip_next_rounded,
                          size: 25,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  //Indicator
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: controller.items.length,
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 7),
                      backgroundColor: const Color(0Xff010935),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      body: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(controller.items[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      controller.items[index].title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Text(
                      controller.items[index].deskripsi,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget getStarted() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF010935),
                  Color(0xFF7981C9),
                ],)
        ),
        width: MediaQuery.of(context).size.width * .9,
        height: 60,
        child: ButtonSwipeRight(
          title: "Mulai Sekarang!",
          fungsi: () async {
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);

            //After we press get started button this onboarding value become true
            // same key
            if (!mounted) return;
            // Navigator.pushReplacement(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.fade, child: const LoginScreen()));
            Get.off(
              const LoginScreen(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 500));
          },
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Membuat objek path untuk menentukan area yang akan dipotong
    var path = Path();
    // Menentukan titik awal path (pojok kiri atas)
    path.lineTo(0, size.height - 65);
    // Menentukan titik kontrol pertama untuk kurva Bezier pertama
    var firstControlPoint = Offset(size.width / 5, size.height);
    // Menentukan titik akhir kurva Bezier pertama
    var firstEndPoint = Offset(size.width / 2, size.height - 20);
    // Menambahkan kurva Bezier pertama ke path
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    // Menentukan titik kontrol kedua untuk kurva Bezier kedua
    var secondControlPoint =
        Offset(size.width - (size.width / 100), size.height - 55);
    // Menentukan titik akhir kurva Bezier kedua
    var secondEndPoint = Offset(size.width, size.height - 0);
    // Menambahkan kurva Bezier kedua ke path
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    // Menambahkan garis lurus ke pojok kanan bawah
    path.lineTo(size.width, size.height - 350);
    // Menambahkan garis lurus ke pojok kanan atas
    path.lineTo(size.width, 0);
    // Menutup path sehingga area yang ditentukan oleh path akan dipotong
    path.close();
    // Mengembalikan path yang telah dibuat
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Metode ini digunakan untuk menentukan apakah path perlu dipotong ulang
    // Di sini, kita mengembalikan false karena path tidak perlu diubah.
    return true;
  }
}
