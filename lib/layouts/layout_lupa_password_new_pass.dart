import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/components/input/input_versi1.dart';
import 'package:project_camp_sewa/services/api_lupa_password.dart';

class LayoutLupaPasswordNewPass extends StatefulWidget {
  const LayoutLupaPasswordNewPass({super.key});

  @override
  State<LayoutLupaPasswordNewPass> createState() =>
      _LayoutLupaPasswordNewPassState();
}

class _LayoutLupaPasswordNewPassState extends State<LayoutLupaPasswordNewPass> {
  ApiLupaPassword apiLupaPassword = Get.put(ApiLupaPassword());
  @override
  Widget build(BuildContext context) {
    final dataKiriman = Get.arguments as Map<String, dynamic>;
    String noTelephone = dataKiriman['nomor_telephone'];
    bool lupaPass = dataKiriman['lupa_password'];
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                            size: 32,
                          ))
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/lock-image-lupa-pass.png",
                  scale: 2.35,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text("Password Baru",
                    style: AppColors.fontStyle(fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Jangan lupa untuk memasukkan kembali password baru Anda pada kolom konfirmasi password.",
                    style: AppColors.fontStyle(fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: AppColors.fontStyle(fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 5,
                  ),
                  child: InputVersiSatu(
                    tipeInput: TextInputType.visiblePassword,
                    controller: apiLupaPassword.newPassController,
                    showEyes: true,
                    passwordTipe: true,
                    iconInput: const Icon(
                      Icons.lock_rounded,
                      size: 26,
                      color: Colors.black,
                    ),
                    placeHolder: "Masukkan Password Baru",
                    ukuranFontPlaceHolder: 16,
                    border: true,
                    ketebalanBorder: 1.7,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 20, bottom: 5, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Konfirmasi Password",
                        style: AppColors.fontStyle(fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputVersiSatu(
                    tipeInput: TextInputType.visiblePassword,
                    controller: apiLupaPassword.confirmPassController,
                    showEyes: true,
                    passwordTipe: true,
                    iconInput: const Icon(
                      Icons.lock_rounded,
                      size: 26,
                      color: Colors.black,
                    ),
                    placeHolder: "Masukkan Password Baru",
                    ukuranFontPlaceHolder: 16,
                    border: true,
                    ketebalanBorder: 1.7,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  child: InkWell(
                    onTap: () {
                      //konfirmasi
                      apiLupaPassword.lupaPassResetPass(context, noTelephone, lupaPass);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF2F2828),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Konfirmasi",
                            style: AppColors.fontStyle(fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
