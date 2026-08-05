import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/constants/database_helper.dart';
import 'package:project_camp_sewa/services/controller_keranjang.dart';

class ItemKeranjangCard extends StatefulWidget {
  final String image;
  final String namaProduk;
  final String variantWarna;
  final String variantUkuran;
  final int harga;
  final int qty;
  final int idKeranjang;
  final int selected;
  final Function() hapus;
  const ItemKeranjangCard(
      {super.key,
      required this.image,
      required this.namaProduk,
      required this.variantWarna,
      required this.variantUkuran,
      required this.harga,
      required this.qty,
      required this.hapus,
      required this.idKeranjang,
      required this.selected});

  @override
  State<ItemKeranjangCard> createState() => _ItemKeranjangCardState();
}

class _ItemKeranjangCardState extends State<ItemKeranjangCard> {
  KeranjangController keranjangController = Get.put(KeranjangController());
  bool dipilih = false;
  int qty = 0;

  @override
  void initState() {
    super.initState();
    qty = widget.qty;
    int checkbox = widget.selected;
    if (checkbox == 0) {
      dipilih = false;
    } else {
      dipilih = true;
    }
  }

  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter = NumberFormat.decimalPattern('id');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
            horizontal:
                BorderSide(color: Colors.black.withValues(alpha: 0.3), width: 0.8)),
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: Colors.orange,
            checkColor: Colors.white,
            value: dipilih,
            onChanged: (bool? value) {
              setState(() {
                dipilih = value!;
                if (dipilih) {
                  Map<String, dynamic> updatedRow = {
                    'selected': 1,
                  };
                  DatabaseHelper.instance
                      .updateKeranjang(widget.idKeranjang, updatedRow, context);
                } else {
                  Map<String, dynamic> updatedRow = {
                    'selected': 0,
                  };
                  DatabaseHelper.instance
                      .updateKeranjang(widget.idKeranjang, updatedRow, context);
                }
                keranjangController.updateTotalHargaKeranjang(context);
                keranjangController.updateTotalItemKeranjang(context);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 12, bottom: 12),
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                      image: NetworkImage(ApiEndpoints.baseUrl +
                          ApiEndpoints.authendpoints.getImageProduk +
                          widget.image), //image Produk
                      fit: BoxFit.fill)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.namaProduk, //Nama Produk
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Text(
                          widget.variantWarna, //variasi warna
                          style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          " , ",
                          style: GoogleFonts.poppins(
                              fontSize: 8, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.variantUkuran, //variasi ukuran
                          style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Text(
                          "IDR. ",
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          formatCurrency(
                              widget.harga.toString()), //harga produk
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          ",00/hari",
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, top: 5),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.5, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (qty >= 0) {
                                        qty++;
                                        Map<String, dynamic> updatedRow = {
                                          'qty': qty,
                                        };
                                        DatabaseHelper.instance.updateKeranjang(
                                            widget.idKeranjang,
                                            updatedRow,
                                            context);
                                      }
                                      keranjangController
                                          .updateTotalHargaKeranjang(context);
                                      keranjangController
                                          .updateTotalItemKeranjang(context);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  qty.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (qty > 1) {
                                        qty--;
                                        Map<String, dynamic> updatedRow = {
                                          'qty': qty,
                                        };
                                        DatabaseHelper.instance.updateKeranjang(
                                            widget.idKeranjang,
                                            updatedRow,
                                            context);
                                      }
                                      keranjangController
                                          .updateTotalHargaKeranjang(context);
                                      keranjangController
                                          .updateTotalItemKeranjang(context);
                                    });
                                  },
                                  child: Icon(
                                    MdiIcons.minus,
                                    size: 21,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: widget.hapus,
            child: Container(
              width: 30,
              decoration: const BoxDecoration(color: Color(0xFFCD1B1B)),
              child: Center(
                  child: Image.asset(
                "assets/icons/trash.png",
                scale: 2.1,
              )),
            ),
          )
        ],
      ),
    );
  }
}

