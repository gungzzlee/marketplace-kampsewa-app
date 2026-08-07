import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonOpsiPengiriman extends StatefulWidget {
  final String? teksOpsi;
  final String? teksHarga;
  final String? image;
  final Color? bgColor;
  final Color? borderColor;
  final Color? teksColor;

  const ButtonOpsiPengiriman(
      {super.key,
      this.image,
      this.bgColor,
      this.borderColor,
      this.teksColor,
      this.teksHarga,
      this.teksOpsi});

  @override
  State<ButtonOpsiPengiriman> createState() => _ButtonOpsiPengirimanState();
}

class _ButtonOpsiPengirimanState extends State<ButtonOpsiPengiriman> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 188,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.borderColor!, width: 1.2),
        color: widget.bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              widget.image!,
              scale: 2,
            ),
            Text(
              widget.teksOpsi!,
              style: AppColors.fontStyle(fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: widget.teksColor),
            ),
            Text(
              widget.teksHarga!,
              style: AppColors.fontStyle(fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: widget.teksColor),
            ),
          ],
        ),
      ),
    );
  }
}
