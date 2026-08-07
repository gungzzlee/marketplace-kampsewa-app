import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KategoriIcon extends StatelessWidget {
  final Function()? aksi;
  final String title;
  final bool selected;
  final Color? activeColor;

  const KategoriIcon(
      {super.key,
      this.aksi,
      required this.title,
      this.selected = false,
      this.activeColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (aksi != null) {
              aksi!();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: selected ? Colors.transparent :Colors.black.withValues(alpha: 0.3)),
                  color: selected ? (activeColor ?? const Color(0xFF00ADD6)) : const Color(0xFFBDBDBD),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Center(
                      child: Text(
                    title,
                    style: AppColors.fontStyle(fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : Colors.black),
                  )),
                )),
          ),
        ),
      ],
    );
  }
}

