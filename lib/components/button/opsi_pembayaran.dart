import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpsiPembayaran extends StatefulWidget {
  final Color? bgColor;
  final Color? teksColor;
  final String? icon;
  final String? opsiBayar;
  final String? keterangan;
  final bool? checklist;
  const OpsiPembayaran(
      {super.key,
      this.bgColor,
      this.teksColor,
      this.opsiBayar,
      this.icon,
      this.checklist,
      this.keterangan});

  @override
  State<OpsiPembayaran> createState() => _OpsiPembayaranState();
}

class _OpsiPembayaranState extends State<OpsiPembayaran> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 30, top: 10, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(widget.icon!, scale: 2),
                const SizedBox(width: 2,),
                Text(
                  widget.opsiBayar!,
                  style: AppColors.fontStyle(fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: widget.teksColor),
                ),
              ],
            ),
            const SizedBox(height: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    widget.keterangan!,
                    style: AppColors.fontStyle(fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: widget.teksColor),
                  ),
                ),
                widget.checklist!
                    ? Icon(
                        Icons.check_rounded,
                        color: widget.teksColor,
                        size: 25,
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}
