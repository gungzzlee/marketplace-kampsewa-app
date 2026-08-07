import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AlamatOpsiPengiriman extends StatefulWidget {
  final double opacity;
  final bool? edit;
  final bool? checklist;
  final String alamat;
  final String? opsi;
  final String? keteranganKirim;
  const AlamatOpsiPengiriman(
      {super.key,
      this.opacity = 1,
      this.edit,
      this.checklist,
      required this.alamat,
      this.opsi,
      this.keteranganKirim});

  @override
  State<AlamatOpsiPengiriman> createState() => _AlamatOpsiPengirimanState();
}

class _AlamatOpsiPengirimanState extends State<AlamatOpsiPengiriman> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 30,
            color: const Color(0xFF2F2828).withValues(alpha: widget.opacity),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Colors.white.withValues(alpha: widget.opacity),
                  ),
                  Text(
                    widget.opsi!,
                    style: AppColors.fontStyle(fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: widget.opacity)),
                  ),
                  widget.edit! ? const Spacer() : const SizedBox(),
                  widget.edit!
                      ? Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                          onTap: (){
                            //edit
                          },
                          child: Text(
                              "Edit",
                              style: AppColors.fontStyle(fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(
                        widget.alamat,
                        style: AppColors.fontStyle(fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withValues(alpha: widget.opacity)),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(
                          MdiIcons.packageVariantClosed,
                          size: 20,
                          color: const Color(0xFFEE2737)
                              .withValues(alpha: widget.opacity),
                        ),
                        Text(
                          widget.keteranganKirim!,
                          style: AppColors.fontStyle(fontSize: 9.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFEE2737)
                                  .withValues(alpha: widget.opacity)),
                        ),
                      ],
                    )
                  ],
                ),
                widget.checklist!
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.black,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

