import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/layouts/layout_alamat.dart';
import 'package:project_camp_sewa/layouts/layout_edit_profile.dart';
import 'package:project_camp_sewa/layouts/layout_lupa_password_new_pass.dart';
import 'package:project_camp_sewa/layouts/layout_tambah_data_toko.dart';
import 'package:project_camp_sewa/screens/screen_login.dart';
import 'package:project_camp_sewa/services/authorization_token.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';

class LayoutProfile extends StatefulWidget {
  const LayoutProfile({super.key});

  @override
  State<LayoutProfile> createState() => _LayoutProfileState();
}

class _LayoutProfileState extends State<LayoutProfile> {
  final DashboardController pageController = Get.put(DashboardController());

  final String _dummyName = 'Agung Pratama';
  final String _dummyEmail = 'agung@email.com';
  final String _dummyPhone = '+62 812-3456-7890';
  final String _dummyAvatar = 'assets/images/man.png';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              // Hero Background
              Container(
                height: 280,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF1AB783),
                      Color(0xFF1AB783), Color(0xFF12825D),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              
              // Decorative Circles
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),

              // Content
              Column(
                children: [
                  const SizedBox(height: 70),
                  _buildHeaderInfo(),
                  const SizedBox(height: 25),
                  _buildStatsCard(),
                  const SizedBox(height: 25),
                  _buildMenuSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.5),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(_dummyAvatar),
              onBackgroundImageError: (_, __) {},
            ),
          ),
          const SizedBox(width: 16),
          // User Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dummyName,
                  style: AppColors.fontStyle(fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _dummyEmail,
                  style: AppColors.fontStyle(fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _dummyPhone,
                  style: AppColors.fontStyle(fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          // Edit Button
          Material(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Get.to(() => const LayoutEditProfile()),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1AB783).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('12', 'Pesanan', Icons.shopping_bag_rounded, const Color(0xFFFFFFFF)),
          _buildStatDivider(),
          _buildStatItem('3', 'Aktif', Icons.local_shipping_rounded, const Color(0xFF10B981)),
          _buildStatDivider(),
          _buildStatItem('4.8', 'Rating', Icons.star_rounded, const Color(0xFFED6723)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: AppColors.fontStyle(fontSize: 20,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2F2828),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppColors.fontStyle(fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFBDBDBD),
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 40,
      width: 1,
      color: const Color(0xFFBDBDBD),
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Text(
              "Pengaturan Akun",
              style: AppColors.fontStyle(fontSize: 16,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2F2828),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: MdiIcons.shoppingOutline,
                  title: 'Pesanan Saya',
                  subtitle: 'Pantau status pesanan',
                  onTap: () {
                    pageController.setPageIndex(2);
                    Get.back();
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: MdiIcons.mapMarkerOutline,
                  title: 'Alamat',
                  subtitle: 'Atur alamat pengiriman',
                  onTap: () {
                    Get.to(() => const LayoutAlamat());
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: MdiIcons.lockOutline,
                  title: 'Ubah Password',
                  subtitle: 'Amankan akun Anda',
                  onTap: () {
                    Get.to(
                      () => const LayoutLupaPasswordNewPass(),
                      arguments: {
                        'nomor_telephone': _dummyPhone,
                        'lupa_password': false,
                      },
                    );
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: MdiIcons.storefrontOutline,
                  title: 'Mulai Menyewakan',
                  subtitle: 'Buka toko perlengkapan',
                  onTap: () {
                    Get.to(() => const LayoutTambahDataToko());
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Text(
              "Lainnya",
              style: AppColors.fontStyle(fontSize: 16,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2F2828),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: _buildMenuItem(
              icon: MdiIcons.logout,
              title: 'Keluar',
              subtitle: 'Akhiri sesi saat ini',
              textColor: const Color(0xFFEE2737),
              iconColor: const Color(0xFFEE2737),
              iconBgColor: const Color(0xFFFEF2F2),
              onTap: () {
                Authorization auth = Authorization();
                auth.deleteId();
                auth.deleteToken();
                Get.off(() => const LoginScreen());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
    Color? iconBgColor,
  }) {
    final Color actualIconColor = iconColor ?? const Color(0xFF1AB783);
    final Color actualIconBgColor = iconBgColor ?? const Color(0xFFFFFFFF);
    final Color actualTextColor = textColor ?? const Color(0xFF2F2828);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: actualIconBgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: actualIconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppColors.fontStyle(fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: actualTextColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppColors.fontStyle(fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFBDBDBD),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 72, right: 20),
      child: Divider(
        height: 1,
        thickness: 1,
        color: const Color(0xFFBDBDBD),
      ),
    );
  }
}
