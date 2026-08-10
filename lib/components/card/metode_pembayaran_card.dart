import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';

class CardMetodePembayaran extends StatefulWidget {
  final String metodePembayaran;
  final String bank;
  final String noRek;
  final Function()? edit;
  const CardMetodePembayaran(
      {super.key,
      required this.metodePembayaran,
      required this.bank,
      required this.noRek,
      this.edit});

  @override
  State<CardMetodePembayaran> createState() => _CardMetodePembayaranState();
}

class _CardMetodePembayaranState extends State<CardMetodePembayaran> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(
                width: 1, color: Colors.black.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF646363).withValues(alpha: 0.3),
                  offset: const Offset(1.5, 1.5),
                  blurRadius: 5.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            children: [
              Image.asset(
                widget.metodePembayaran == "Transfer"
                    ? "assets/images/metode-pembayaran-transfer.png"
                    : "assets/images/metode-pembayaran-cod.png",
                scale: 2,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.metodePembayaran,
                            style: AppColors.fontStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Visibility(
                            visible: widget.metodePembayaran == "Transfer",
                            child: InkWell(
                              onTap: widget.edit,
                              child: Text(
                                "Edit",
                                style: AppColors.fontStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.bank,
                        style: AppColors.fontStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.noRek,
                        style: AppColors.fontStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
