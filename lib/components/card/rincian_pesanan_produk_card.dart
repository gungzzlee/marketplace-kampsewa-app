import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RincianPesananProdukCard extends StatefulWidget {
  final String? image;
  final String? namaProduk;
  final String variasiUkuran;
  final String variasiWarna;
  final String? qty;
  final String? harga;
  const RincianPesananProdukCard(
      {super.key,
      this.image,
      this.namaProduk,
      this.variasiUkuran = "",
      this.variasiWarna = "",
      this.qty,
      this.harga});

  @override
  State<RincianPesananProdukCard> createState() =>
      _RincianPesananProdukCardState();
}

class _RincianPesananProdukCardState extends State<RincianPesananProdukCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.black.withValues(alpha: 0.3), width: 0.6))
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: AssetImage(widget.image!)),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF494949).withValues(alpha: 0.2),
                          offset: const Offset(0, 0),
                          blurRadius: 3)
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            widget.namaProduk!,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.variasiUkuran != "" &&
                                      widget.variasiWarna != ""
                                  ? "${widget.variasiUkuran}/${widget.variasiWarna}"
                                  : widget.variasiUkuran != ""
                                      ? widget.variasiUkuran
                                      : widget.variasiWarna,
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const Spacer(),
                            Text(
                              "X",
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.qty!,
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                //harga
                                children: [
                                  Text(
                                    "IDR. ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    widget.harga!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ",00/hari",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

