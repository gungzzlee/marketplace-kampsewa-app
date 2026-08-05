import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/components/bottomsheet/bottom_sheet_produk.dart';
import 'package:project_camp_sewa/components/button/icon_kategori.dart';
import 'package:project_camp_sewa/components/card/produk_terlaris_card.dart';
import 'package:project_camp_sewa/components/input/search_bar.dart';
import 'package:project_camp_sewa/layouts/layout_detail_product.dart';
import 'package:project_camp_sewa/layouts/layout_keranjang.dart';
import 'package:project_camp_sewa/layouts/layout_search_screen.dart';
import 'package:project_camp_sewa/models/produk_model.dart';
import 'package:project_camp_sewa/services/api_produk.dart';
import 'package:project_camp_sewa/services/controller_search.dart';

class LayoutProduct extends StatefulWidget {
  const LayoutProduct({super.key});

  @override
  State<LayoutProduct> createState() => _LayoutProductState();
}

class _LayoutProductState extends State<LayoutProduct> {
  ApiProduk apiProduk = Get.put(ApiProduk());
  TeksSearchController textSearchController = Get.put(TeksSearchController());

  List kategoriIcon = [
    "Semua",
    "Rekomendasi",
    "Terbaru",
    "Termurah",
    "Termahal",
    "Tenda",
    "Pakaian",
    "Peralatan"
  ];

  String filterKategori = "Semua";
  String? searchTeks;
  String? variantWarna;

  void getSystemBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFE8E9EC),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  void initState() {
    getSystemBarTheme();
    super.initState();
    apiProduk.getProduk(context, null, null);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                            size: 28,
                          )),
                    ),
                    Text(
                      "Produk",
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            Get.to(const LayoutKeranjang());
                          },
                          icon: const Icon(
                            Icons.shopping_cart_rounded,
                            color: Colors.black,
                            size: 27,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: MySearchBar(
                  aksi: () {
                    Get.to(const LayoutSearchScreen());
                  },
                  teks: textSearchController.searchTeks,
                  backgroundColor: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.2),
                  fontColor: Colors.black,
                  fontSize: 13.5,
                  iconColor: Colors.black,
                  iconSize: 30,
                ),
              ),
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 15),
                      child: Container(
                        height: 38,
                        width: 42,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image:
                                    AssetImage("assets/icons/filter-icon.png"),
                                scale: 1.7)),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => KategoriIcon(
                            title: kategoriIcon[index],
                            selected: filterKategori == kategoriIcon[index],
                            aksi: () {
                              setState(() {
                                filterKategori = kategoriIcon[index];
                              });
                              apiProduk.getProduk(
                                  context, null, filterKategori);
                              textSearchController.searchTeks.value =
                                  "Cari Peralatan Yang Kamu Inginkan...";
                            },
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 3,
                          ),
                          itemCount: kategoriIcon.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.62,
                  child: Obx(() {
                    List<ProdukModel> listProduk = apiProduk.listProduk;
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.740,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        scrollDirection: Axis.vertical,
                        itemCount: listProduk.length,
                        itemBuilder: (context, index) {
                          ProdukModel list = listProduk[index];
                          return ProdukTerlarisDashboard(
                            image: list.image,
                            namaProduk: list.namaProduk,
                            harga: list.harga.toString(),
                            rating: list.rating,
                            aksi: () {
                              apiProduk.getDetailProduk(
                                  context, list.idProduk.toString());
                              apiProduk.getProdukBottomSheet(context, null,
                                  null, list.idProduk.toString());
                              Get.to(const LayoutDetailProduct(), arguments: {
                                'idToko': list.idUser,
                                'namaToko':list.namaToko,
                                'idProduk': list.idProduk,
                                'namaProduk': list.namaProduk,
                                'fotoProduk': list.image
                              });
                            },
                            aksiKeranjang: () {
                              apiProduk.getProdukBottomSheet(context, null,
                                  null, list.idProduk.toString());
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BottomSheetProduk(
                                      image: list.image,
                                      namaProduk: list.namaProduk,
                                      harga: list.harga.toString(),
                                      idProduk: list.idProduk,
                                      idToko: list.idUser,
                                      namaToko: list.namaToko,
                                    );
                                  });
                            },
                          );
                        });
                  }),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

