import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class RiwayatCard extends StatefulWidget {
  final String namaToko;
  final String namaProduk;
  final String qty;
  final String variasiWarna;
  final String variasiUkuran;
  final String qtyProdukLain;
  final String rating;
  final String harga;
  final String totalPesanan;
  final String hari;
  final String fotoProduk;
  final String? statusHari;
  final String statusTransaksi;

  const RiwayatCard(
      {super.key,
      required this.namaToko,
      required this.namaProduk,
      required this.fotoProduk,
      required this.qty,
      this.variasiWarna = "",
      this.variasiUkuran = "",
      required this.qtyProdukLain,
      required this.rating,
      required this.harga,
      required this.totalPesanan,
      required this.hari,
      required this.statusTransaksi,
      this.statusHari = "hari pengembalian"});

  @override
  State<RiwayatCard> createState() => _RiwayatCardState();
}

class _RiwayatCardState extends State<RiwayatCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF646363).withValues(alpha: 0.45),
                offset: const Offset(0, 2),
                blurRadius: 3.5)
          ],
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2F2828),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 5),
                          child: Image.asset(
                            "assets/icons/icon-store.png",
                            scale: 1.7,
                          ),
                        ),
                        Text(
                          widget.namaToko,
                          style: AppColors.fontStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: widget.fotoProduk.startsWith('http')
                                ? NetworkImage(widget.fotoProduk) as ImageProvider
                                : AssetImage(widget.fotoProduk)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF646363)
                                  .withValues(alpha: 0.2),
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
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                widget.namaProduk,
                                style: AppColors.fontStyle(
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
                                  style: AppColors.fontStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "X",
                                  style: AppColors.fontStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  widget.qty,
                                  style: AppColors.fontStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    //Rating
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFED6723),
                                        size: 15,
                                      ),
                                      Text(
                                        widget.rating,
                                        style: AppColors.fontStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFED6723)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    //harga
                                    children: [
                                      Text(
                                        "IDR. ",
                                        style: AppColors.fontStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        widget.harga,
                                        style: AppColors.fontStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        ",00",
                                        style: AppColors.fontStyle(
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          MdiIcons.viewGridPlusOutline,
                          color: Colors.black,
                          size: 18,
                        ),
                        Text(
                          widget.qtyProdukLain,
                          style: AppColors.fontStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Text(
                          " Produk Lainnya",
                          style: AppColors.fontStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Pesanan: IDR. ",
                          style: AppColors.fontStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          widget.totalPesanan,
                          style: AppColors.fontStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          ",00",
                          style: AppColors.fontStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(
                            MdiIcons.clock,
                            size: 17,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.hari,
                          style: AppColors.fontStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          " ${widget.statusHari!}",
                          style: AppColors.fontStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: Icon(
                            MdiIcons.wallet,
                            color: Colors.black,
                            size: 17,
                          ),
                        ),
                        Text(
                          widget.statusTransaksi,
                          style: AppColors.fontStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: widget.statusTransaksi == "Lunas"
                                  ? Colors.green
                                  : Colors.red),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
