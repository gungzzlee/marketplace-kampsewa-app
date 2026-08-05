import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';

class ProdukTerlarisDashboard extends StatefulWidget {
  final String image;
  final String namaProduk;
  final String harga;
  final String rating;
  final Function() aksi;
  final Function() aksiKeranjang;
  const ProdukTerlarisDashboard(
      {super.key,
      required this.image,
      required this.namaProduk,
      required this.harga,
      required this.rating,
      required this.aksi, 
      required this.aksiKeranjang});

  @override
  State<ProdukTerlarisDashboard> createState() =>
      _ProdukTerlarisDashboardState();
}

class _ProdukTerlarisDashboardState extends State<ProdukTerlarisDashboard> {
  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter =
        NumberFormat.decimalPattern('id'); // Use 'id' for Indonesian locale
    return formatter.format(number);
  }

  String formatRating(String numberString) {
    final number = double.parse(numberString);
    return number.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: widget.aksi,
        child: Container(
          width: 180,
          height: 240,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF494949).withValues(alpha: 0.3),
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 5.0)
              ]),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 175,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(ApiEndpoints.baseUrl +
                              ApiEndpoints.authendpoints.getImageProduk +
                              widget.image))),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 50,
                  height: 35,
                  child: Text(
                    widget.namaProduk,
                    style: GoogleFonts.poppins(
                        fontSize: 11, fontWeight: FontWeight.w600),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //Ini ku pisah pisah supaya ketika ambil harga di database ngga usah nambahin IDR dulu
                          children: [
                            Text(
                              "IDR. ",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              formatCurrency(widget.harga),
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "/hari",
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              size: 16.5,
                              color: Color(0xFFEAB308),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              formatRating(widget.rating),
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFEAB308)),
                            )
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      //button keranjangnya
                      onTap: widget.aksiKeranjang,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF000E54)),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/icon-keranjang.png",
                            scale: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

