import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/components/card/rincian_pesanan_produk_card.dart';

class LayoutRincianPesanan extends StatefulWidget {
  const LayoutRincianPesanan({super.key});

  @override
  State<LayoutRincianPesanan> createState() => _LayoutRincianPesananState();
}

class _LayoutRincianPesananState extends State<LayoutRincianPesanan> {
  bool statusPesanan = true;
  String? statusBar = "berlangsung"; //status = dibatalkan, berlangsung, selesai
  bool buttonBayarSewa = true;
  bool buttonBatalPesanan = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 28,
                        )),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          "Rincian Pesanan",
                          style: AppColors.fontStyle(fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              height: 2,
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: ListView(
                children: [
                  statusPesanan
                      ? Container(
                          color: statusBar == "dibatalkan"
                              ? const Color(0xFFEE2737)
                              : const Color(0xFF1AB783),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      statusBar == "dibatalkan"
                                          ? "Pembatalan Berhasil"
                                          : statusBar == "berlangsung"
                                              ? "Sewa Berlangsung"
                                              : "Sewa Selesai",
                                      style: AppColors.fontStyle(fontSize: 17.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "20-05-2024", //tanggal status bar
                                      style: AppColors.fontStyle(fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  statusBar == "dibatalkan"
                                      ? "assets/icons/icon-bar-dibatalkan.png"
                                      : statusBar == "berlangsung"
                                          ? "assets/icons/icon-bar-berlangsung.png"
                                          : "assets/icons/icon-bar-selesai.png",
                                  scale: 2.2,
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.black.withValues(alpha: 0.3), width: 1),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/calendar-icon.png",
                              scale: 2.1,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Tanggal Sewa : ",
                              style: AppColors.fontStyle(fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const Spacer(),
                            Text(
                              "20/05/2024 - 25/05/2024", //tanggal sewa
                              style: AppColors.fontStyle(fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.black.withValues(alpha: 0.3), width: 1)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Opsi Pengiriman",
                            style: AppColors.fontStyle(fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Ambil Ditempat", //opsi pengiriman
                            style: AppColors.fontStyle(fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            //alamat pengiriman
                            "Rumah Outdoor  Jl. Sumatra XIII No.20, Tegal Boto Lor, Sumbersari, Kec. Sumbersari, Kabupaten Jember",
                            style: AppColors.fontStyle(fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: const Color(0xFF2F2828),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/icon-store.png",
                            scale: 2,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Abayhq Shop", //nama toko
                            style: AppColors.fontStyle(fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: ((context, index) =>
                        const RincianPesananProdukCard(
                          image: "assets/images/produk1.jpeg",
                          namaProduk: "The Nort Face 4",
                          variasiUkuran: "XXL",
                          variasiWarna: "Putih",
                          qty: "2",
                          harga: "20.000",
                        )),
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  width: 1)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Durasi Sewa",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "2", //durasi sewa
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  " hari",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 2, left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Sub Total Produk",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "IDR. ",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  "60.000", //sub total
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  ",00",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 2, left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Biaya Layanan",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "IDR. ",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  "1.000", //biaya layanan
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  ",00",
                                  style: AppColors.fontStyle(fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 6, left: 15, right: 15, bottom: 8),
                            child: Row(
                              children: [
                                Text(
                                  "Total Pembayaran",
                                  style: AppColors.fontStyle(fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "IDR. ",
                                  style: AppColors.fontStyle(fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  "61.000", //total pembayaran
                                  style: AppColors.fontStyle(fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  ",00",
                                  style: AppColors.fontStyle(fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Colors.black.withValues(alpha: 0.3),
                                width: 1)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/coin-icon.png",
                            scale: 2,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Metode Pembayaran",
                            style: AppColors.fontStyle(fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            "Bayar Ditempat", //metode pembayaran
                            style: AppColors.fontStyle(fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  width: 1)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Diminta Oleh",
                                  style: AppColors.fontStyle(fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "Customer",
                                  style: AppColors.fontStyle(fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 2, left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  statusBar == "dibatalkan"
                                      ? "Di Batalkan Pada"
                                      : "Waktu Pemesanan",
                                  style: AppColors.fontStyle(fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "21-05-2024", //tanggal dibatalkan / pemesanan
                                  style: AppColors.fontStyle(fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 2, left: 15, right: 15),
                            child: Row(
                              children: [
                                Text(
                                  statusBar == "dibatalkan"
                                      ? "Alasan"
                                      : "Waktu Pesanan Selesai",
                                  style: AppColors.fontStyle(fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Text(
                                  "22-05-2024", //alasan atau waktu pesanan selesai
                                  style: AppColors.fontStyle(fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Colors.black.withValues(alpha: 0.5), width: 1.5)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  buttonBayarSewa
                      ? Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: InkWell(
                          onTap: () {
                            //button bayar sekarang atau sewa lagi
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFF2F2828)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    statusBar == "selesai"
                                        ? "Sewa Lagi"
                                        : "Bayar Sekarang",
                                    style: AppColors.fontStyle(fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),
                  buttonBatalPesanan
                      ? Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            //button bayar sekarang atau sewa lagi
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFEE2737)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    "Batalkan Pesanan",
                                    style: AppColors.fontStyle(fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

