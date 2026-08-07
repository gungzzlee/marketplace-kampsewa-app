import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/components/input/otp_input.dart';
import 'package:project_camp_sewa/services/api_lupa_password.dart';

class LayoutLupaPasswordOTP extends StatefulWidget {
  const LayoutLupaPasswordOTP({super.key});

  @override
  State<LayoutLupaPasswordOTP> createState() => _LayoutLupaPasswordOTPState();
}

class _LayoutLupaPasswordOTPState extends State<LayoutLupaPasswordOTP> {
  ApiLupaPassword apiLupaPassword = Get.put(ApiLupaPassword());
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final dataKiriman = Get.arguments as Map<String, dynamic>;
    String noTelephone = dataKiriman['nomor_telephone'];
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
                  "assets/images/otp-image-lupa-pass.png",
                  scale: 2.35,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text("Periksa WhatsApp Mu",
                    style: AppColors.fontStyle(fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Kami telah mengirimkan kode OTP ke WhatsApp mu.",
                    style: AppColors.fontStyle(fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpInput(
                        controller: otp1,
                        focusNode: focusNode1,
                        nextFocusNode: focusNode2,
                      ),
                      OtpInput(
                          controller: otp2,
                          focusNode: focusNode2,
                          nextFocusNode: focusNode3,
                          previousFocusNode: focusNode1),
                      OtpInput(
                          controller: otp3,
                          focusNode: focusNode3,
                          nextFocusNode: focusNode4,
                          previousFocusNode: focusNode2),
                      OtpInput(
                          controller: otp4,
                          focusNode: focusNode4,
                          nextFocusNode: focusNode5,
                          previousFocusNode: focusNode3),
                      OtpInput(
                          controller: otp5,
                          focusNode: focusNode5,
                          nextFocusNode: focusNode6,
                          previousFocusNode: focusNode4),
                      OtpInput(
                        controller: otp6,
                        focusNode: focusNode6,
                        previousFocusNode: focusNode5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: InkWell(
                    onTap: () {
                      //verifikasi
                      String inputOTP = otp1.text +
                          otp2.text +
                          otp3.text +
                          otp4.text +
                          otp5.text +
                          otp6.text;
                      apiLupaPassword.lupaPassVerifikasiOTP(
                          context, inputOTP, noTelephone);
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
                            "Verifikasi",
                            style: AppColors.fontStyle(fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Kirim Ulang OTP? ",
                  style: AppColors.fontStyle(fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
