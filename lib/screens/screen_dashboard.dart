import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.grid_view_rounded, label: 'Produk'),
    _NavItem(icon: Icons.receipt_long_rounded, label: 'Riwayat'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      bottomNavigationBar: _buildBottomNav(),
      body: Obx(() => pages[pageController.pageIndex.value]),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1AB783),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1AB783).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Obx(() {
            final selectedIndex = pageController.pageIndex.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => pageController.setPageIndex(index)),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 16 : 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.45),
                          size: 26,
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Text(
                            item.label,
                            style: AppColors.fontStyle(color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
