// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/components/card/group_produk_keranjang.dart';
import 'package:project_camp_sewa/components/dialog/alert_dialog.dart';
import 'package:project_camp_sewa/layouts/layout_checkout.dart';
import 'package:project_camp_sewa/services/controller_keranjang.dart';

class LayoutKeranjang extends StatefulWidget {
  const LayoutKeranjang({super.key});

  @override
  State<LayoutKeranjang> createState() => _LayoutKeranjangState();
}

class _LayoutKeranjangState extends State<LayoutKeranjang> {
  KeranjangController keranjangController = Get.put(KeranjangController());

  @override
  void initState() {
    super.initState();
    keranjangController.getUniqueStores(context);
    keranjangController.updateTotalHargaKeranjang(context);
    keranjangController.updateTotalItemKeranjang(context);
    keranjangController.getSelectedTokoCheckout(context);
  }

  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter =
        NumberFormat.decimalPattern('id'); // Use 'id' for Indonesian locale
    return formatter.format(number);
  }

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
                          "Keranjang",
                          style: GoogleFonts.poppins(
                              fontSize: 21,
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
              height: 2.3,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(() {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final store =
                                keranjangController.uniqueStores[index];
                            return GroupProdukKeranjang(
                              namaToko: store['nama_toko'],
                              idToko: store['id_toko'],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          itemCount: keranjangController.uniqueStores.length,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              height: 3,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 18, bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          "Total Item",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Obx(() {
                          return Text(
                            keranjangController.totalItemKeranjang.value
                                .toString(), //total item
                            style: GoogleFonts.poppins(
                                fontSize: 14.5, fontWeight: FontWeight.w700),
                          );
                        }),
                        Text(
                          " Item",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Text(
                          "IDR. ",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5, fontWeight: FontWeight.w700),
                        ),
                        Obx(() {
                          return Text(
                            formatCurrency(keranjangController
                                .totalHargaKeranjang.value
                                .toString()), //total harga
                            style: GoogleFonts.poppins(
                                fontSize: 14.5, fontWeight: FontWeight.w700),
                          );
                        }),
                        Text(
                          ",00/hari",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () async{
                      await keranjangController.getSelectedTokoCheckout(context);
                      int totalToko =
                          keranjangController.totalSelectedTokoCheckout.value;
                      if (totalToko == 1) {
                        Get.to(const LayoutCheckout());
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: CustomAlertDialog(
                                    sukses: false,
                                    title: "Maaf Atas Ketidaknyamanannya",
                                    teks:
                                        "Anda Hanya Bisa Checkout Produk Pada 1 Toko Yang Sama"),
                              );
                            });
                      }
                    },
                    child: Container(
                      height: 55,
                      width: 355,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF010935)),
                      child: Center(
                        child: Text(
                          "Checkout",
                          style: GoogleFonts.poppins(
                              fontSize: 18.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

