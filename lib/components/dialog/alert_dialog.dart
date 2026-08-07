import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog extends StatefulWidget {
  final String? teks;
  final String? title;
  final bool sukses;
  const CustomAlertDialog(
      {super.key, this.sukses = true, this.teks, this.title});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
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
              widget.sukses
                  ? "assets/images/sukses-logo.png"
                  : "assets/images/error-logo.png",
              scale: widget.sukses ? 7.5 : 6,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              widget.title != null
                  ? widget.title!
                  : widget.sukses
                      ? "Sukses"
                      : "Error",
              style: AppColors.fontStyle(fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.teks!,
              textAlign: TextAlign.center,
              style: AppColors.fontStyle(fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: widget.sukses
                          ? const Color(0xFF1AB783)
                          : const Color(0xFFEE2737),
                      boxShadow: [
                        BoxShadow(
                            color: widget.sukses
                                ? const Color(0xFF1AB783).withValues(alpha: 0.7)
                                : const Color(0xFFEE2737).withValues(alpha: 0.7),
                            offset: const Offset(0, 0),
                            blurRadius: 5.0)
                      ]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Okey",
                        style: AppColors.fontStyle(fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

