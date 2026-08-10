import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/components/input/input_versi1.dart';
import 'package:project_camp_sewa/services/api_lupa_password.dart';

class LayoutLupaPassword extends StatefulWidget {
  const LayoutLupaPassword({super.key});

  @override
  State<LayoutLupaPassword> createState() => _LayoutLupaPasswordState();
}

class _LayoutLupaPasswordState extends State<LayoutLupaPassword> {
  ApiLupaPassword apiLupaPassword = Get.put(ApiLupaPassword());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
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
            Text("Lupa Password",
                style: AppColors.fontStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Kamu harus verifikasi menggunakan nomor hpmu untuk mendapatkan kode OTP",
                style: AppColors.fontStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: InputVersiSatu(
                tipeInput: TextInputType.phone,
                controller: apiLupaPassword.telephoneController,
                iconInput: const Icon(
                  Icons.phone_rounded,
                  size: 30,
                  color: Colors.black,
                ),
                placeHolder: "Masukkan Nomor HP",
                ukuranFontPlaceHolder: 16,
                border: true,
                ketebalanBorder: 1.7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: InkWell(
                onTap: () {
                  apiLupaPassword.lupaPass(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF2F2828),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        "Kirim OTP",
                        style: AppColors.fontStyle(
                            fontSize: 17,
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
      )),
    );
  }
}
