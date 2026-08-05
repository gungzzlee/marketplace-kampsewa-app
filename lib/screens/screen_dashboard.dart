import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_camp_sewa/layouts/layout_dashboard.dart';
import 'package:project_camp_sewa/layouts/layout_product.dart';
import 'package:project_camp_sewa/layouts/layout_profile.dart';
import 'package:project_camp_sewa/screens/screen_riwayat.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  DashboardController pageController = Get.put(DashboardController());
  List pages = const [LayoutDashboard(), LayoutProduct(), RiwayatScreen(), LayoutProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
                    color: Colors.black.withValues(alpha: 0.5),
                    strokeAlign: BorderSide.strokeAlignOutside,
                    width: 2.4)),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
          child: Obx(() {
            return GNav(
                backgroundColor: Colors.white,
                color: const Color(0xFF000E54),
                activeColor: const Color(0xFF000E54),
                tabBackgroundColor: const Color(0xFFE1E1E1),
                gap: 4,
                padding: const EdgeInsets.all(10),
                selectedIndex: pageController.pageIndex.value,
                onTabChange: (index) {
                  setState(() {
                    pageController.setPageIndex(index);
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.home_filled,
                    iconSize: 30,
                    text: "Home",
                  ),
                  GButton(
                    icon: Icons.dashboard_rounded,
                    iconSize: 30,
                    text: "Produk",
                  ),
                  GButton(
                    icon: Icons.assignment,
                    iconSize: 30,
                    text: "Riwayat",
                  ),
                  GButton(
                    icon: Icons.account_box,
                    iconSize: 30,
                    text: "Profile",
                  ),
                ]);
          }),
        ),
      ),
      body: Obx(() => pages[pageController.pageIndex.value]),
    );
  }
}

