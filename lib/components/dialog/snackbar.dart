import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar extends StatefulWidget {
  final String? teks;
  final String? title;
  final bool sukses;
  const CustomSnackBar({super.key, this.title, this.teks, this.sukses = true});

  @override
  State<CustomSnackBar> createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white,
          border: Border.all(color: Colors.black.withValues(alpha: 0.5), width: 2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                offset: const Offset(0, 0),
                blurRadius: 10)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          children: [
            Image.asset(
              widget.sukses
                  ? "assets/images/sukses-logo.png"
                  : "assets/images/error-logo.png",
              scale: widget.sukses ? 10 : 8.5,
            ),
            const SizedBox(width: 3,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title != null
                  ? widget.title!
                  : widget.sukses
                      ? "Sukses"
                      : "Error",
                  style: AppColors.fontStyle(fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.9,
                  child: Text(
                    widget.teks!,
                    maxLines: null,
                    style: AppColors.fontStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  //Get.back();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 15,
                ))
          ],
        ),
      ),
    );
  }
}

