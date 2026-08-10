import 'package:project_camp_sewa/theme_colors.dart';
// ignore_for_file: avoid_print
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/components/card/item_variant.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/constants/database_helper.dart';
import 'package:project_camp_sewa/models/detail_produk_model.dart';
import 'package:project_camp_sewa/services/api_produk.dart';

class LayoutDetailProduct extends StatefulWidget {
  const LayoutDetailProduct({super.key});

  @override
  State<LayoutDetailProduct> createState() => _LayoutDetailProductState();
}

class _LayoutDetailProductState extends State<LayoutDetailProduct> {
  ApiProduk apiProduk = Get.put(ApiProduk());
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentIndex = 0;
  String? selectedWarna;
  String? selectedUkuran;
  String? harga;
  String? stok;
  int? idToko;
  int? idProduk;
  String? namaProduk;
  String? namaToko;
  String? fotoProduk;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    idToko = arguments['idToko'];
    idProduk = arguments['idProduk'];
    namaProduk = arguments['namaProduk'];
    fotoProduk = arguments['fotoProduk'];
    namaToko = arguments['namaToko'];
  }

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
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(children: [
              Obx(() {
                List<String> imageList = apiProduk.imageDetailProduk;
                return CarouselSlider(
                  items: imageList.map((item) {
                    return ClipRRect(
                      child: Image.network(
                        ApiEndpoints.baseUrl +
                            ApiEndpoints.authendpoints.getImageProduk +
                            item,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    aspectRatio: 1,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                );
              }),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Obx(() {
                  List<String> imageList = apiProduk.imageDetailProduk;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 18.5 : 8.5,
                          height: 9,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? const Color(0xFF000000)
                                  : const Color(0xFFBDBDBD)),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      //button back
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 32,
                      ),
                    ),
                  )),
            ]),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 45,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                border: Border(
                    top: BorderSide(
                        color: Colors.black.withValues(alpha: 0.25),
                        width: 2.5),
                    left: BorderSide(
                        color: Colors.black.withValues(alpha: 0.25), width: 2),
                    right: BorderSide(
                        color: Colors.black.withValues(alpha: 0.25), width: 2)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, top: 15, bottom: 10),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFED6723),
                                size: 25,
                              ),
                              Obx(() {
                                DetailProdukModel? list =
                                    apiProduk.detailProduk.value;
                                return Text(
                                  list != null
                                      ? formatRating(list.rating)
                                      : formatRating("5.0"), //rating
                                  style: AppColors.fontStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFED6723)),
                                );
                              }),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 38,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFE6E6E6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() {
                                        DetailProdukModel? list =
                                            apiProduk.detailProduk.value;
                                        return Text(
                                          list != null
                                              ? list.totalUlasan.toString()
                                              : "100", //ulasan
                                          style: AppColors.fontStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        );
                                      }),
                                      Text(
                                        " Ulasan",
                                        style: AppColors.fontStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(() {
                            DetailProdukModel? list =
                                apiProduk.detailProduk.value;
                            return Text(
                              list != null
                                  ? list.namaProduk
                                  : "unknown", //Nama Produk
                              style: AppColors.fontStyle(
                                  fontSize: 21.5, fontWeight: FontWeight.w700),
                            );
                          }),
                          const SizedBox(
                            height: 2,
                          ),
                          Obx(() {
                            DetailProdukModel? list =
                                apiProduk.detailProduk.value;
                            return Text(
                              list != null
                                  ? list.deskripsiProduk
                                  : "unknown", //Deskripsi Produk
                              style: AppColors.fontStyle(
                                  fontSize: 12.5, fontWeight: FontWeight.w400),
                            );
                          }),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Warna",
                            style: AppColors.fontStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 35,
                            child: Obx(() {
                              List<String> listWarna = apiProduk.colors;
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ItemVariant(
                                      item: listWarna[index],
                                      selected:
                                          selectedWarna == listWarna[index],
                                      aksi: () {
                                        apiProduk.updateAllUniqueSizes(
                                            color: listWarna[index]);
                                        setState(() {
                                          selectedWarna = listWarna[index];
                                        });
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 5,
                                      ),
                                  itemCount: listWarna.length);
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, bottom: 3),
                            child: Text(
                              "Ukuran",
                              style: AppColors.fontStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: Obx(() {
                              List<String> listUkuran = apiProduk.uniqueSizes;
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => ItemVariant(
                                        item: listUkuran[index],
                                        selected:
                                            selectedUkuran == listUkuran[index],
                                        aksi: () {
                                          setState(() {
                                            selectedUkuran = listUkuran[index];
                                          });

                                          if (selectedWarna != null &&
                                              selectedUkuran != null) {
                                            var result =
                                                apiProduk.getStockAndPrice(
                                                    selectedWarna!,
                                                    selectedUkuran!);
                                            if (result != null) {
                                              setState(() {
                                                harga =
                                                    result['harga'].toString();
                                                int stokInt = result['stok'];
                                                stok = stokInt.toString();
                                              });
                                            }
                                          }
                                        },
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 5,
                                      ),
                                  itemCount: listUkuran.length);
                            }),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Syarat dan Ketentuan",
                            style: AppColors.fontStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Text(
                            "1. Menjaminkan Kartu identitas saat pengambilan (KTP, KTM, Kartu Pelajar). \n2. Kerusakan, kehilangan dan keterlambatan akan dikenakan denda. \n3. Keterlambatan maksimal 2 jam setelah masa sewa habis.",
                            style: AppColors.fontStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 85,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.black.withValues(alpha: 0.25),
                                width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: stok != null,
                                child: Row(
                                  children: [
                                    Text(
                                      "Stok : ",
                                      style: AppColors.fontStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      stok != null ? stok! : "",
                                      style: AppColors.fontStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "IDR. ",
                                    style: AppColors.fontStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                  Obx(() {
                                    DetailProdukModel? list =
                                        apiProduk.detailProduk.value;
                                    return Text(
                                      harga != null
                                          ? formatCurrency(harga!)
                                          : list != null
                                              ? formatCurrency(
                                                  list.hargaSewa.toString())
                                              : "-", //harga produk
                                      style: AppColors.fontStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black),
                                    );
                                  }),
                                  Text(
                                    ",00/hari",
                                    style: AppColors.fontStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              if (selectedWarna != null &&
                                  selectedUkuran != null) {
                                print(idToko);
                                print(idProduk);
                                print(namaToko);
                                print(fotoProduk);
                                print(namaProduk);
                                print(harga);
                                Map<String, dynamic> newRow = {
                                  'id_toko': idToko,
                                  'id_produk': idProduk,
                                  'nama_toko': namaToko,
                                  'foto_produk': fotoProduk,
                                  'nama_produk': namaProduk,
                                  'variant_warna': selectedWarna,
                                  'variant_ukuran': selectedUkuran,
                                  'harga': harga,
                                  'qty': 1,
                                  'selected': 0
                                };
                                await DatabaseHelper.instance
                                    .insertKeranjang(newRow, context);
                              } else {
                                const snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: CustomSnackBar(
                                      sukses: false,
                                      teks:
                                          "Pilih Warna dan Ukuran Terlebih Dahulu",
                                    ));

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: const Color(0xFF2F2828)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/add-cart.png",
                                      scale: 2,
                                    ),
                                    Text(
                                      "Keranjang",
                                      style: AppColors.fontStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
