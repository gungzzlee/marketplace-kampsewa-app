import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog2 extends StatefulWidget {
  final String? teks;
  final Function() hapus;
  const CustomAlertDialog2({super.key, this.teks, required this.hapus});

  @override
  State<CustomAlertDialog2> createState() => _CustomAlertDialog2State();
}

class _CustomAlertDialog2State extends State<CustomAlertDialog2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/icons/warning-icon.png",
              scale: 7.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Hapus Produk?",
              style: AppColors.fontStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            Text(
              widget.teks!,
              textAlign: TextAlign.center,
              style: AppColors.fontStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 25, bottom: 15, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withValues(alpha: 0.2),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                offset: const Offset(0, 0),
                                blurRadius: 3.0)
                          ]),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 18),
                          child: Text(
                            "Batal",
                            style: AppColors.fontStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.hapus,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 25, bottom: 15, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFFEE2737),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xFFEE2737),
                                offset: Offset(0, 0),
                                blurRadius: 3.0)
                          ]),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Text(
                            "Hapus",
                            style: AppColors.fontStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
