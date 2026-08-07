import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/components/card/item_variant.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/constants/database_helper.dart';
import 'package:project_camp_sewa/services/api_produk.dart';

class BottomSheetProduk extends StatefulWidget {
  final String? image;
  final String? namaProduk;
  final String? harga;
  final int? idProduk;
  final int? idToko;
  final String? namaToko;
  const BottomSheetProduk({
    super.key,
    this.image,
    this.namaProduk,
    this.harga,
    this.idProduk,
    this.idToko,
    this.namaToko,
  });

  @override
  State<BottomSheetProduk> createState() => _BottomSheetProdukState();
}

class _BottomSheetProdukState extends State<BottomSheetProduk> {
  ApiProduk apiProduk = Get.put(ApiProduk());
  String? pemberitahuan = "";
  String? selectedWarna;
  String? selectedUkuran;
  String? harga;
  String? stok;
  int qty = 1;

  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter =
        NumberFormat.decimalPattern('id'); // Use 'id' for Indonesian locale
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.black.withValues(alpha: 0.2), width: 1)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(ApiEndpoints.baseUrl +
                                  ApiEndpoints.authendpoints.getImageProduk +
                                  widget.image!))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.85,
                            child: Text(
                              widget.namaProduk!,
                              maxLines: null,
                              style: AppColors.fontStyle(fontSize: 15.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "IDR. ",
                                style: AppColors.fontStyle(fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                harga != null
                                    ? formatCurrency(harga!)
                                    : formatCurrency(widget.harga!),
                                style: AppColors.fontStyle(fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                ",00/hari",
                                style: AppColors.fontStyle(fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: stok != null,
                            child: Row(
                              children: [
                                Text(
                                  "Stok : ",
                                  style: AppColors.fontStyle(fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  stok != null ? stok! : "",
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
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Warna",
                  style: AppColors.fontStyle(fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 30,
                  child: Obx(() {
                    List<String> listWarna = apiProduk.colors;
                    return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ItemVariant(
                            item: listWarna[index],
                            selected: selectedWarna == listWarna[index],
                            aksi: () {
                              apiProduk.updateAllUniqueSizes(
                                  color: listWarna[index]);
                              setState(() {
                                selectedWarna = listWarna[index];
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 5,
                            ),
                        itemCount: listWarna.length);
                  }),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Ukuran",
                  style: AppColors.fontStyle(fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                    height: 30,
                    child: Obx(() {
                      List<String> listUkuran = apiProduk.uniqueSizes;
                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ItemVariant(
                                item: listUkuran[index],
                                selected: selectedUkuran == listUkuran[index],
                                aksi: () {
                                  setState(() {
                                    selectedUkuran = listUkuran[index];
                                  });

                                  if (selectedWarna != null &&
                                      selectedUkuran != null) {
                                    var result = apiProduk.getStockAndPrice(
                                        selectedWarna!, selectedUkuran!);
                                    if (result != null) {
                                      setState(() {
                                        harga = result['harga'].toString();
                                        int stokInt = result['stok'];
                                        stok = stokInt.toString();
                                        pemberitahuan = "";
                                        if (qty > stokInt) {
                                          qty = stokInt;
                                        }
                                      });
                                    }
                                  }
                                },
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: listUkuran.length);
                    })),
                const Spacer(),
                Visibility(
                  visible: pemberitahuan != null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.5),
                        child: Text(
                          pemberitahuan!,
                          style: AppColors.fontStyle(fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.red.withValues(alpha: 0.8)),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jumlah",
                      style: AppColors.fontStyle(fontSize: 16.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.5, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (stok != null) {
                                    if (qty < int.parse(stok!)) {
                                      qty++;
                                      pemberitahuan = "";
                                    } else {
                                      pemberitahuan =
                                          "*Quantity Telah Mencapai Batas Stok";
                                    }
                                  } else {
                                    pemberitahuan =
                                        "*Pilih Warna dan Ukuran Terlebih Dahulu";
                                  }
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              qty.toString(),
                              style: AppColors.fontStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (qty > 1) {
                                    qty--;
                                    pemberitahuan = "";
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: Icon(
                                  MdiIcons.minus,
                                  size: 21,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.25),
                    height: 1.2,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (selectedWarna != null && selectedUkuran != null) {
                      Map<String, dynamic> newRow = {
                        'id_toko': widget.idToko,
                        'id_produk': widget.idProduk,
                        'nama_toko': widget.namaToko,
                        'foto_produk': widget.image,
                        'nama_produk': widget.namaProduk,
                        'variant_warna': selectedWarna,
                        'variant_ukuran': selectedUkuran,
                        'harga': harga,
                        'qty': qty,
                        'selected': 0
                      };
                      await DatabaseHelper.instance
                          .insertKeranjang(newRow, context);
                      Get.back();
                    } else {
                      setState(() {
                        pemberitahuan = "*Pilih Warna dan Ukuran Terebih Dahulu";
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2F2828)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            "Tambahkan ke Keranjang",
                            style: AppColors.fontStyle(fontSize: 17.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 25,
                )))
      ],
    );
  }
}

