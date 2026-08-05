import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/layouts/layout_alamat.dart';
import 'package:project_camp_sewa/layouts/layout_edit_profile.dart';
import 'package:project_camp_sewa/layouts/layout_lupa_password_new_pass.dart';
import 'package:project_camp_sewa/layouts/layout_tambah_data_toko.dart';
import 'package:project_camp_sewa/models/user.dart';
import 'package:project_camp_sewa/screens/screen_login.dart';
import 'package:project_camp_sewa/services/api_data_user.dart';
import 'package:project_camp_sewa/services/authorization_token.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';

class LayoutProfile extends StatefulWidget {
  const LayoutProfile({super.key});

  @override
  State<LayoutProfile> createState() => _LayoutProfileState();
}

class _LayoutProfileState extends State<LayoutProfile> {
  ApiDataUser apiDataUser = Get.put(ApiDataUser());
  DashboardController pageController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    apiDataUser.getDataUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Profile",
              style: GoogleFonts.poppins(
                  fontSize: 22.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 12.5),
              child: Obx(() {
                final User? dataUser = apiDataUser.dataUser.value;
                if (dataUser != null) {
                  return CircleAvatar(
                    //photo profile
                    radius: 55,
                    backgroundImage: NetworkImage(ApiEndpoints.baseUrl +
                        ApiEndpoints.authendpoints.getFotoProfile +
                        dataUser.image!),
                  );
                } else {
                  return const CircleAvatar(
                    //photo profile
                    radius: 55,
                    backgroundImage: AssetImage("assets/images/error-pp.jpg"),
                  );
                }
              }),
            ),
            Obx(() {
              final User? dataUser = apiDataUser.dataUser.value;
              return Text(
                dataUser!.name!,
                style: GoogleFonts.poppins(
                    fontSize: 20.5, fontWeight: FontWeight.w700),
              );
            }),
            Obx(() {
              final User? dataUser = apiDataUser.dataUser.value;
              return Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 5),
                child: Text(
                  dataUser!.email!,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              );
            }),
            Obx(() {
              final User? dataUser = apiDataUser.dataUser.value;
              return Text(
                dataUser!.nomorTelephone!,
                style: GoogleFonts.poppins(
                    fontSize: 15.5, fontWeight: FontWeight.w500),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: InkWell(
                onTap: () {
                  //edit profile
                  Get.to(const LayoutEditProfile());
                },
                child: Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF010935)),
                  child: Center(
                    child: Text(
                      "Edit Profile",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              height: 2,
            ),
            InkWell(
              onTap: () {
                //ke Pesanan Saya
                pageController.setPageIndex(2);
                Get.back();
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.assignment,
                        size: 30,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Pesanan Saya",
                        style: GoogleFonts.poppins(
                            fontSize: 16.5, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      const Icon(Icons.navigate_next_rounded,
                          size: 40, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //ke alamat
                Get.to(const LayoutAlamat());
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Alamat",
                        style: GoogleFonts.poppins(
                            fontSize: 16.5, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      const Icon(Icons.navigate_next_rounded,
                          size: 40, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //Ubah password
                final User? dataUser = apiDataUser.dataUser.value;
                String noTelephone = dataUser!.nomorTelephone!;
                var kirimData = {
                  'nomor_telephone': noTelephone,
                  'lupa_password': false
                };
                Get.to(const LayoutLupaPasswordNewPass(), arguments: kirimData);
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock,
                        size: 30,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Ubah Password",
                        style: GoogleFonts.poppins(
                            fontSize: 16.5, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      const Icon(Icons.navigate_next_rounded,
                          size: 40, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //Mulai Menyewakan
                Get.to(const LayoutTambahDataToko());
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.storeCog,
                        size: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Mulai Menyewakan",
                        style: GoogleFonts.poppins(
                            fontSize: 16.5, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      const Icon(Icons.navigate_next_rounded,
                          size: 40, color: Colors.black)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              height: 2,
            ),
            InkWell(
              onTap: () {
                //Logout
                Authorization auth = Authorization();
                auth.deleteId();
                auth.deleteToken();
                Get.off(const LoginScreen());
              },
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.logout,
                        size: 30,
                        color: Colors.red,
                      ),
                      Text(
                        "Keluar",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

