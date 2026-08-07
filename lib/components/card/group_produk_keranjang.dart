import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/components/card/keranjang_card.dart';
import 'package:project_camp_sewa/components/dialog/alert_dialog2.dart';
import 'package:project_camp_sewa/components/dialog/loading_dialog.dart';
import 'package:project_camp_sewa/constants/database_helper.dart';
import 'package:project_camp_sewa/services/controller_keranjang.dart';

class GroupProdukKeranjang extends StatefulWidget {
  final String? namaToko;
  final int? idToko;
  const GroupProdukKeranjang({super.key, this.namaToko, this.idToko});

  @override
  State<GroupProdukKeranjang> createState() => _GroupProdukKeranjangState();
}

class _GroupProdukKeranjangState extends State<GroupProdukKeranjang> {
  KeranjangController keranjangController = Get.put(KeranjangController());
  LoadingDialog loading = Get.put(LoadingDialog());
  late Future<List<Map<String, dynamic>>> _keranjangFuture;

  void _loadKeranjang() {
    setState(() {
      _keranjangFuture =
          DatabaseHelper.instance.getKeranjangByIdToko(context, widget.idToko!);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadKeranjang();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(25)),
          border: Border.symmetric(
              vertical:
                  BorderSide(color: Colors.black.withValues(alpha: 0.3), width: 1)),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF646363).withValues(alpha: 0.35),
                offset: const Offset(-2.0, 3.0),
                blurRadius: 2.0)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF2F2828),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Image.asset(
                        "assets/icons/icon-store.png",
                        scale: 1.8,
                      ),
                    ),
                    Text(
                      widget.namaToko!,
                      style: AppColors.fontStyle(fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: _keranjangFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 55,
                    ));
                  } else {
                    final keranjangList = snapshot.data!;
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final listProduk = keranjangList[index];
                          return ItemKeranjangCard(
                            image: listProduk['foto_produk'],
                            namaProduk: listProduk['nama_produk'],
                            variantUkuran: listProduk['variant_ukuran'],
                            variantWarna: listProduk['variant_warna'],
                            harga: listProduk['harga'],
                            qty: listProduk['qty'],
                            idKeranjang: listProduk['id'],
                            selected: listProduk['selected'],
                            hapus: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        content: CustomAlertDialog2(
                                          teks:
                                              "Yakin Ingin Menghapus Produk ${listProduk['nama_produk']} ?",
                                          hapus: () {
                                            setState(() {
                                              DatabaseHelper.instance
                                                  .deleteKeranjang(
                                                      listProduk['id'],
                                                      context);
                                            });
                                            Get.back();
                                            _loadKeranjang();
                                            keranjangController
                                                .updateTotalHargaKeranjang(
                                                    context);
                                            keranjangController
                                                .updateTotalItemKeranjang(
                                                    context);
                                            keranjangController
                                                .getUniqueStores(context);
                                          },
                                        ));
                                  });
                            },
                          );
                        },
                        itemCount: keranjangList.length);
                  }
                }),
          ],
        ),
      ),
    );
  }
}

