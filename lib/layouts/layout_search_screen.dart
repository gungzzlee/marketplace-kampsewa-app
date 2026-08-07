import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/components/card/rekomendasi_cari_card.dart';
import 'package:project_camp_sewa/models/produk_model.dart';
import 'package:project_camp_sewa/services/api_produk.dart';
import 'package:project_camp_sewa/services/api_riwayat_cari.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';
import 'package:project_camp_sewa/services/controller_search.dart';

class LayoutSearchScreen extends StatefulWidget {
  const LayoutSearchScreen({super.key});

  @override
  State<LayoutSearchScreen> createState() => _LayoutSearchScreenState();
}

class _LayoutSearchScreenState extends State<LayoutSearchScreen> {
  DashboardController pageController = Get.put(DashboardController());
  TextEditingController searchController = TextEditingController();
  TeksSearchController textSearchController = Get.put(TeksSearchController());
  ApiRiwayatCari apiRiwayatCari = Get.put(ApiRiwayatCari());
  ApiProduk apiProduk = Get.put(ApiProduk());

  bool showAllSearchHistory = false;
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    apiRiwayatCari.showRiwayatCari(context);
  }

  String getFirstWord(String text) {
    return text.split(' ').first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                    onPressed: () {
                      navigator?.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        size: 35, color: Colors.black)),
              ),
              Text(
                "KampSewa.",
                style: AppColors.fontStyle(fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.bellBadge,
                        size: 27, color: Colors.black)),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Temukan Peralatan.",
              style: AppColors.fontStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Cari peralatan untuk bertualang yang anda butuhkan dan anda inginkan.",
              style: AppColors.fontStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 55,
              width: 385,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Icon(
                      MdiIcons.magnify,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          textSearchController.searchTeks.value = value;
                          apiProduk.getProduk(context, value, null);
                          apiRiwayatCari.insertRiwayatCari(context, value);
                          pageController.setPageIndex(1);
                          Get.back();
                        }
                      },
                      focusNode: searchFocusNode,
                      decoration: InputDecoration(
                          hintText: "Cari Peralatan...",
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(MdiIcons.windowClose),
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                              });
                            },
                          )),
                      style: AppColors.fontStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Riwayat Pencarian",
                style: AppColors.fontStyle(fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withValues(alpha: 0.5)),
              ),
            ),
            Container(
                color: Colors.white,
                child: Obx(
                  () => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (showAllSearchHistory)
                          ? apiRiwayatCari.riwayatCari.length
                          : (apiRiwayatCari.riwayatCari.length > 4)
                              ? 4
                              : apiRiwayatCari.riwayatCari.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  searchController.clear();
                                  searchController.text +=
                                      apiRiwayatCari.riwayatCari[index];
                                  searchFocusNode.requestFocus();
                                });
                              },
                              child: Row(
                                children: [
                                  Text(apiRiwayatCari.riwayatCari[index],
                                      style: AppColors.fontStyle(fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      apiRiwayatCari.deleteRiwayatCari(context,
                                          apiRiwayatCari.riwayatCari[index]);
                                      apiRiwayatCari.showRiwayatCari(context);
                                    },
                                    child: Icon(
                                      MdiIcons.windowClose,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                )),
            Obx(
              () => Visibility(
                visible: apiRiwayatCari.riwayatCari.length > 4 &&
                    !showAllSearchHistory,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showAllSearchHistory = true;
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          'Lihat Semua',
                          style: AppColors.fontStyle(fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withValues(alpha: 0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showAllSearchHistory,
              child: InkWell(
                onTap: () {
                  apiRiwayatCari.deleteRiwayatCari(context, null);
                  apiRiwayatCari.showRiwayatCari(context);
                  setState(() {
                    showAllSearchHistory = false;
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        'Hapus semua riwayat',
                        style: AppColors.fontStyle(fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red.shade800.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "Rekomendasi Pencarian",
                style: AppColors.fontStyle(fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withValues(alpha: 0.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 765,
                child: Obx(() {
                  List<ProdukModel> listProduk =
                      apiProduk.listProdukRekomendasi;
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.740,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listProduk.length,
                      itemBuilder: (context, index) {
                        ProdukModel list = listProduk[index];
                        return RekomendasiCariCard(
                          image: list.image,
                          namaProduk: list.namaProduk,
                          rating: list.rating,
                          aksi: () {
                            String value = getFirstWord(list.namaProduk);
                            textSearchController.searchTeks.value = value;
                            apiProduk.getProduk(context, value, null);
                            apiRiwayatCari.insertRiwayatCari(context, value);
                            pageController.setPageIndex(1);
                            Get.back();
                          },
                        );
                      });
                }),
              ),
            )
          ])),
        ],
      )),
    );
  }
}

