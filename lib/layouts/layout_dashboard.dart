import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_camp_sewa/components/bottomsheet/bottom_sheet_produk.dart';
import 'package:project_camp_sewa/components/card/berita_dash_card.dart';
import 'package:project_camp_sewa/components/button/icon_kategori.dart';
import 'package:project_camp_sewa/components/card/produk_terlaris_card.dart';
import 'package:project_camp_sewa/components/card/wisata_dash_card.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/layouts/layout_detail_product.dart';
import 'package:project_camp_sewa/layouts/layout_keranjang.dart';
import 'package:project_camp_sewa/layouts/layout_search_screen.dart';
import 'package:project_camp_sewa/models/api_response.dart';
import 'package:project_camp_sewa/models/berita_model.dart';
import 'package:project_camp_sewa/models/wisata_model.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';
import 'package:project_camp_sewa/theme_colors.dart';

class LayoutDashboard extends StatefulWidget {
  const LayoutDashboard({super.key});

  @override
  State<LayoutDashboard> createState() => _LayoutDashboardState();
}

class _LayoutDashboardState extends State<LayoutDashboard> {
  DashboardController pageController = Get.put(DashboardController());

  // Dummy data
  final String dummyUserName = 'Agung Pratama';
  final String dummyUserLocation = 'Sumbersari, Jember';

  final List<Map<String, dynamic>> dummyProduk = [
    {
      'namaProduk': 'Tenda Dome Coleman',
      'harga': '75000',
      'rating': 4.8,
      'image': 'assets/images/tenda-dome-coleman.jpg'
    },
    {
      'namaProduk': 'Sleeping Bag',
      'harga': '35000',
      'rating': 4.5,
      'image': 'assets/images/slepping-bag.jpg'
    },
    {
      'namaProduk': 'Kompor Portable',
      'harga': '25000',
      'rating': 4.7,
      'image': 'assets/images/kompor-portable.jpg'
    },
    {
      'namaProduk': 'Set Alat Masak',
      'harga': '40000',
      'rating': 4.6,
      'image': 'assets/images/set-alat-masak.jpg'
    },
    {
      'namaProduk': 'Kursi Lipat',
      'harga': '20000',
      'rating': 4.3,
      'image': 'assets/images/kursi-lipat.jpg'
    },
  ];

  final List<String> dummyIklan = [
    'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
    'https://images.unsplash.com/photo-1510312305653-8ed496efae75?w=800',
    'https://images.unsplash.com/photo-1533240332313-0db49b459ad6?w=800',
  ];

  late List<WisataModel> wisataList;
  late List<BeritaModel> beritaList;
  List kategoriIcon = ["Tenda", "Pakaian", "Tas & Sepatu", "Perlengkapan"];
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    wisataList = DummyProductApiResponse.getDataWisata();
    beritaList = DummyProductApiResponse.getDataBerita();
  }

  Widget _buildSectionLabel(String title, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF2C4E40),
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: const EdgeInsets.only(right: 8),
              ),
              Text(
                title,
                style: AppColors.fontStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2C4E40),
                ),
              ),
            ],
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF), // Light gray background
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Section with Gradient & Decorations
                Stack(
                  children: [
                    // Abstract decorative background
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF2C4E40),
                              Color(0xFF2C4E40),
                              Color(0xFF2C4E40),
                            ],
                            stops: [0.0, 0.4, 1.0],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                      ),
                    ),
                    // Decorative shape 1 (Top Right)
                    Positioned(
                      top: -40,
                      right: -20,
                      child: Transform.rotate(
                        angle: 0.5,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    // Decorative shape 2 (Bottom Left)
                    Positioned(
                      bottom: -20,
                      left: -50,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                    ),
                    // Decorative shape 3 (Top Left)
                    Positioned(
                      top: 20,
                      left: 40,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                    ),
                    // Header Content
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 60, bottom: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    AssetImage("assets/images/error-pp.jpg"),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dummyUserName,
                                      style: AppColors.fontStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_rounded,
                                          color: Colors.white70,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          dummyUserLocation,
                                          style: AppColors.fontStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              _buildHeaderIcon(
                                icon: Icons.notifications_none_rounded,
                                onTap: () {
                                  const snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: CustomSnackBar(
                                      sukses: false,
                                      title: "Coming Soon",
                                      teks:
                                          "Fitur Notification Akan Tersedia Segera",
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                },
                              ),
                              const SizedBox(width: 10),
                              _buildHeaderIcon(
                                icon: Icons.shopping_bag_outlined,
                                onTap: () => Get.to(const LayoutKeranjang()),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          // Glassmorphism Search Bar
                          InkWell(
                            onTap: () => Get.to(const LayoutSearchScreen()),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              height: 52,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    size: 26,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "Cari Perlengkapan Camping...",
                                    style: AppColors.fontStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Colors.white.withValues(alpha: 0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Banner Carousel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        items: dummyIklan.map((url) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          );
                        }).toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2.2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: dummyIklan.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  carouselController.animateToPage(entry.key),
                              child: Container(
                                width: currentIndex == entry.key ? 20 : 8,
                                height: 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Kategori
                _buildSectionLabel("Kategori"),
                const SizedBox(height: 12),
                SizedBox(
                  height: 55,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => KategoriIcon(
                      title: kategoriIcon[index],
                      selected: true,
                      activeColor: AppColors.orange,
                      aksi: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Kategori ${kategoriIcon[index]} diklik')),
                        );
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemCount: kategoriIcon.length,
                  ),
                ),
                const SizedBox(height: 25),

                // Produk Terlaris
                _buildSectionLabel(
                  "Terlaris",
                  trailing: InkWell(
                    onTap: () => pageController.setPageIndex(1),
                    child: Text(
                      "Lihat Semua",
                      style: AppColors.fontStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C4E40),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 270,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final produk = dummyProduk[index];
                      return ProdukTerlarisDashboard(
                        image: produk['image'],
                        namaProduk: produk['namaProduk'],
                        harga: produk['harga'],
                        rating: produk['rating'].toString(),
                        aksi: () {
                          Get.to(const LayoutDetailProduct(), arguments: {
                            'idToko': 1,
                            'idProduk': index + 1,
                            'namaProduk': produk['namaProduk'],
                            'fotoProduk': produk['image'],
                            'namaToko': 'Toko Camping',
                          });
                        },
                        aksiKeranjang: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return BottomSheetProduk(
                                image: produk['image'],
                                namaProduk: produk['namaProduk'],
                                harga: produk['harga'],
                                idProduk: index + 1,
                                idToko: 1,
                                namaToko: 'Toko Camping',
                              );
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 15),
                    itemCount: dummyProduk.length,
                  ),
                ),
                const SizedBox(height: 25),

                // Rekomendasi Wisata
                _buildSectionLabel("Rekomendasi Wisata"),
                const SizedBox(height: 12),
                SizedBox(
                  height: 185,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
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
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 15),
                    itemCount: wisataList.length,
                  ),
                ),
                const SizedBox(height: 25),

                // Berita Terkini
                _buildSectionLabel("Berita Terkini"),
                const SizedBox(height: 12),
                ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    BeritaModel list = beritaList[index];
                    return BeritaCard(
                      image: list.image,
                      title: list.judul,
                      source: list.source,
                      url: list.link,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: beritaList.length,
                ),
                const SizedBox(height: 100), // Bottom padding for nav bar
              ],
            ),
          ),
        ));
  }

  Widget _buildHeaderIcon(
      {required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
