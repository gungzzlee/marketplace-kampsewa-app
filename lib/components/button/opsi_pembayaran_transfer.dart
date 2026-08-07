import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpsiPembayaranTransfer extends StatefulWidget {
  final String bank;
  final bool? selected;
  const OpsiPembayaranTransfer({super.key, required this.bank, this.selected});

  @override
  State<OpsiPembayaranTransfer> createState() => _OpsiPembayaranTransferState();
}

class _OpsiPembayaranTransferState extends State<OpsiPembayaranTransfer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.white, width: 1)),
          color: Color(0xFF2F2828)),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20, top: 12, bottom: 12),
        child: Row(
          children: [
            Image.asset("assets/icons/selected-opsi-bayar.png", scale: 2,),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(
                widget.bank,
                style: AppColors.fontStyle(fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            widget.selected == true ? const Spacer() : const SizedBox(),
            widget.selected == true
                ? const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 25,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
