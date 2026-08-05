import 'package:flutter/material.dart' hide CarouselController;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_camp_sewa/components/bottomsheet/bottom_sheet_produk.dart';
import 'package:project_camp_sewa/components/card/berita_dash_card.dart';
import 'package:project_camp_sewa/components/button/icon_kategori.dart';
import 'package:project_camp_sewa/components/card/produk_terlaris_card.dart';
import 'package:project_camp_sewa/components/card/wisata_dash_card.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/layouts/layout_detail_product.dart';
import 'package:project_camp_sewa/layouts/layout_keranjang.dart';
import 'package:project_camp_sewa/layouts/layout_search_screen.dart';
import 'package:project_camp_sewa/models/api_response.dart';
import 'package:project_camp_sewa/models/berita_model.dart';
import 'package:project_camp_sewa/models/iklan_model.dart';
import 'package:project_camp_sewa/models/produk_model.dart';
import 'package:project_camp_sewa/models/user.dart';
import 'package:project_camp_sewa/models/wisata_model.dart';
import 'package:project_camp_sewa/services/api_data_user.dart';
import 'package:project_camp_sewa/services/api_iklan.dart';
import 'package:project_camp_sewa/services/api_produk.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';

class LayoutDashboard extends StatefulWidget {
  const LayoutDashboard({super.key});

  @override
  State<LayoutDashboard> createState() => _LayoutDashboardState();
}

class _LayoutDashboardState extends State<LayoutDashboard> {
  ApiDataUser apiDataUser = Get.put(ApiDataUser());
  ApiIklan apiIklan = Get.put(ApiIklan());
  ApiProduk apiProduk = Get.put(ApiProduk());
  DashboardController pageController = Get.put(DashboardController());

  late List<WisataModel> wisataList;
  late List<BeritaModel> beritaList;
  List kategoriIcon = ["Tenda", "Pakaian", "Tas & Sepatu", "Perlengkapan"];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    apiDataUser.getDataUser(context);
    apiIklan.getIklan(context);
    apiProduk.getProdukRatingTertinggi(context);
    wisataList = DummyProductApiResponse.getDataWisata();
    beritaList = DummyProductApiResponse.getDataBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 70, bottom: 25),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/dash-header-img.jpeg"),
                    fit: BoxFit.fill,
                    opacity: 0.7),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  children: [
                    Obx(() {
                      final User? dataUser = apiDataUser.dataUser.value;
                      if (dataUser != null) {
                        return CircleAvatar(
                          //photo profile
                          radius: 30,
                          backgroundImage: NetworkImage(ApiEndpoints.baseUrl +
                              ApiEndpoints.authendpoints.getFotoProfile +
                              dataUser.image!),
                        );
                      } else {
                        return const CircleAvatar(
                          //photo profile
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/error-pp.jpg"),
                        );
                      }
                    }),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          //nama user
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Obx(() {
                            final User? dataUser = apiDataUser.dataUser.value;
                            if (dataUser != null) {
                              return Text(
                                dataUser.name!,
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              );
                            } else {
                              return Text(
                                "Unknown",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              );
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                //icon lokasi dibawah nama
                                Icons.location_pin,
                                color: Colors.black,
                                size: 16,
                              ),
                              Text(
                                //lokasi user
                                "Sumbersari, Jember",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        //fungsi klik notification
                        //DatabaseHelper.instance.deleteAllKeranjang(context);
                        const snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: CustomSnackBar(
                              sukses: false,
                              title: "Coming Soon",
                              teks: "Fitur Notification Akan Tersedia Segera",
                            ));

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.notifications_rounded,
                            color: Colors.black,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const LayoutKeranjang());
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.shopping_cart_rounded,
                            color: Colors.black,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        // field cari peralatan
                        child: InkWell(
                          onTap: () {
                            Get.to(const LayoutSearchScreen());
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.black.withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.search_rounded,
                                  color: Colors.black.withValues(alpha: 0.45),
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Cari Peralatan...",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withValues(alpha: 0.45)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rekomendasi",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Stack(children: [
                    InkWell(
                      onTap: () {
                        //tap iklannya maka akan menampilkan barang/toko pengiklan
                      },
                      child: Obx(() {
                        List<IklanModel> iklan = apiIklan.listIklan;
                        return CarouselSlider(
                          //iklannya disini
                          items: iklan.map((item) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20), // Atur radius lengkungan iklannya
                              child: Image.network(
                                ApiEndpoints.baseUrl +
                                    ApiEndpoints.authendpoints.getImageIklan +
                                    item.poster,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          }).toList(),
                          carouselController: carouselController,
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 2,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                        );
                      }),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Obx(() {
                          List<IklanModel> iklan = apiIklan.listIklan;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: iklan.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: currentIndex == entry.key ? 17 : 7,
                                  height: 7.0,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: currentIndex == entry.key
                                          ? Colors.white
                                          : const Color(0xFF010935)),
                                ),
                              );
                            }).toList(),
                          );
                        })),
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kategori",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: SizedBox(
                    height: 55,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => KategoriIcon(
                        title: kategoriIcon[index],
                        selected: true,
                        aksi: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Kategori ${kategoriIcon[index]} diklik')),
                          );
                        },
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 2,
                      ),
                      itemCount: kategoriIcon.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Terlaris",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          //lihat semua rating tertinggi
                          apiProduk.getProduk(context, null, "Rekomendasi");
                          pageController.setPageIndex(1);
                        },
                        child: Text(
                          "Lihat Semua",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFBBBBBB),
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                  child: SizedBox(
                    height: 260,
                    child: Obx(() {
                      List<ProdukModel> listProduk =
                          apiProduk.listProdukRekomendasi;
                      return ListView.separated(
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
                                'idProduk': list.idProduk,
                                'namaProduk': list.namaProduk,
                                'fotoProduk': list.image,
                                'namaToko': list.namaToko
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
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 12,
                        ),
                        itemCount: listProduk.length,
                        scrollDirection: Axis.horizontal,
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Rekomendasi Wisata",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: SizedBox(
                    height: 185,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        WisataModel list = wisataList[index];
                        return WisataCard(
                          image: list.image,
                          title: list.wisata,
                          deskripsi: list.deskripsi,
                          lokasi: list.lokasi,
                          url: list.source,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                      itemCount: wisataList.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Berita Terkini",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: SizedBox(
                    height: 110 * 8, //110 dikali item count
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        BeritaModel list = beritaList[index];
                        return BeritaCard(
                          image: list.image,
                          title: list.judul,
                          source: list.source,
                          url: list.link,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: beritaList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //scrollDirection: Axis.vertical
                    ),
                  ),
                ),
              ], //Batas Scroll Isi kontennya
            ),
          ),
        ],
      ),
    );
  }
}

