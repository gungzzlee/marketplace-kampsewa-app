import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_camp_sewa/components/bottomsheet/bottom_sheet_produk.dart';
import 'package:project_camp_sewa/components/card/berita_dash_card.dart';
import 'package:project_camp_sewa/components/card/produk_terlaris_card.dart';
import 'package:project_camp_sewa/components/card/wisata_dash_card.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/layouts/layout_detail_product.dart';
import 'package:project_camp_sewa/layouts/layout_keranjang.dart';
import 'package:project_camp_sewa/layouts/layout_search_screen.dart';
import 'package:project_camp_sewa/models/api_response.dart';
import 'package:project_camp_sewa/models/berita_model.dart';
import 'package:project_camp_sewa/models/iklan_model.dart';
import 'package:project_camp_sewa/models/wisata_model.dart';
import 'package:project_camp_sewa/services/api_data_user.dart';
import 'package:project_camp_sewa/services/api_iklan.dart';
import 'package:project_camp_sewa/services/api_produk.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';
import 'package:project_camp_sewa/services/controller_keranjang.dart';
import 'package:project_camp_sewa/theme_colors.dart';

class LayoutDashboard extends StatefulWidget {
  const LayoutDashboard({super.key});

  @override
  State<LayoutDashboard> createState() => _LayoutDashboardState();
}

class _LayoutDashboardState extends State<LayoutDashboard> {
  DashboardController pageController = Get.put(DashboardController());
  ApiDataUser apiDataUser = Get.put(ApiDataUser());
  ApiIklan apiIklan = Get.put(ApiIklan());
  ApiProduk apiProduk = Get.put(ApiProduk());
  KeranjangController keranjangController = Get.put(KeranjangController());

  // Fallback promo banners used when API returns no iklan
  final List<Map<String, dynamic>> _fallbackBanners = [
    {
      'title': 'Sewa Peralatan\nCamping Mudah',
      'subtitle': 'Ribuan pilihan alat camping berkualitas tersedia.',
      'image': 'assets/images/tenda-dome-coleman.jpg',
    },
    {
      'title': 'Diskon Tenda 20%',
      'subtitle': 'Promo spesial minggu ini untuk semua jenis tenda.',
      'image': 'assets/images/slepping-bag.jpg',
    },
  ];

  late List<WisataModel> wisataList;
  late List<BeritaModel> beritaList;

  final List<Map<String, dynamic>> kategori = [
    {"title": "Semua Produk", "icon": Icons.category_rounded, "param": ""},
    {"title": "Tenda", "icon": Icons.house_rounded, "param": "tenda"},
    {"title": "Pakaian", "icon": Icons.checkroom_rounded, "param": "pakaian"},
    {"title": "Tas & Sepatu", "icon": Icons.backpack_outlined, "param": "tas"},
    {
      "title": "Peralatan",
      "icon": Icons.build_outlined,
      "param": "peralatan"
    },
  ];
  int selectedCategoryIndex = 0;

  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    wisataList = DummyProductApiResponse.getDataWisata();
    beritaList = DummyProductApiResponse.getDataBerita();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      apiDataUser.getDataUser(context);
      apiIklan.getIklan(context);
      // Use getFeaturedProduk (rekomendasi endpoint) so products always
      // appear on Home — getProduk excludes the logged-in user's own products.
      apiProduk.getFeaturedProduk(context);
      keranjangController.updateTotalItemKeranjang(context);
    });
  }

  void _filterByKategori(int index) {
    setState(() => selectedCategoryIndex = index);
    // Re-fetch home products with category filter
    apiProduk.getFeaturedProduk(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildHeader(),
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildCategories(),
                const SizedBox(height: 20),
                _buildPromoBanner(),
                const SizedBox(height: 24),
                _buildFeaturedProducts(),
                const SizedBox(height: 24),
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
                const SizedBox(height: 24),
                _buildSectionLabel("Berita Terkini"),
                const SizedBox(height: 12),
                ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
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
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Profile photo (dynamic)
          Obx(() {
            final user = apiDataUser.dataUser.value;
            final imageUrl = user?.image ?? '';
            return Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF2C4E40).withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: ClipOval(child: _buildProfileImage(imageUrl)),
            );
          }),
          const SizedBox(width: 12),

          // Greeting text (dynamic)
          Expanded(
            child: Obx(() {
              final user = apiDataUser.dataUser.value;
              final name = user?.name ?? '---';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back 👋",
                    style: AppColors.fontStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8E8E8E),
                    ),
                  ),
                  Text(
                    name,
                    style: AppColors.fontStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF2F2828),
                      letterSpacing: -0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            }),
          ),

          // Cart icon with red dot badge
          Obx(() {
            final itemCount = keranjangController.totalItemKeranjang.value;
            return InkWell(
              onTap: () => Get.to(const LayoutKeranjang()),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border:
                      Border.all(color: Colors.grey.shade200, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Color(0xFF2F2828),
                      size: 22,
                    ),
                    if (itemCount > 0)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEE2737),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProfileImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return Image.asset(
        'assets/images/error-pp.jpg',
        fit: BoxFit.cover,
        width: 48,
        height: 48,
      );
    }
    final fullUrl = imageUrl.startsWith('http')
        ? imageUrl
        : ApiEndpoints.baseUrl +
            ApiEndpoints.authendpoints.getFotoProfile +
            imageUrl;
    return Image.network(
      fullUrl,
      fit: BoxFit.cover,
      width: 48,
      height: 48,
      errorBuilder: (_, __, ___) => Image.asset(
        'assets/images/error-pp.jpg',
        fit: BoxFit.cover,
        width: 48,
        height: 48,
      ),
    );
  }

  // ── Search Bar ───────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Get.to(const LayoutSearchScreen()),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF2C4E40),
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Cari alat camping...",
                      style: AppColors.fontStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFBDBDBD),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF2C4E40),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2C4E40).withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.tune_rounded,
                  color: Colors.white, size: 22),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  // ── Category Chips ───────────────────────────────────────────────────────────

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: kategori.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == selectedCategoryIndex;
          final cat = kategori[index];
          return GestureDetector(
            onTap: () => _filterByKategori(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2C4E40) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2C4E40)
                      : Colors.grey.shade300,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF2C4E40)
                              .withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cat['icon'] as IconData,
                    size: 14,
                    color:
                        isSelected ? Colors.white : const Color(0xFF8E8E8E),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cat['title'] as String,
                    style: AppColors.fontStyle(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF8E8E8E),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Promo Banner Carousel ────────────────────────────────────────────────────

  Widget _buildPromoBanner() {
    return Obx(() {
      final iklanList = apiIklan.listIklan;
      final bool useApi = iklanList.isNotEmpty;
      final int bannerCount =
          useApi ? iklanList.length : _fallbackBanners.length;

      return Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              aspectRatio: 2.1,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() => currentBannerIndex = index);
              },
            ),
            items: List.generate(bannerCount, (index) {
              if (useApi) {
                return _buildApiBannerItem(iklanList[index]);
              } else {
                return _buildFallbackBannerItem(_fallbackBanners[index]);
              }
            }),
          ),
          if (bannerCount > 1) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(bannerCount, (i) {
                return GestureDetector(
                  onTap: () => carouselController.animateToPage(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: currentBannerIndex == i ? 20 : 7,
                    height: 7,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentBannerIndex == i
                          ? const Color(0xFF2C4E40)
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              }),
            ),
          ],
        ],
      );
    });
  }

  /// Banner dari API iklan (full poster image + title overlay)
  Widget _buildApiBannerItem(IklanModel iklan) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C4E40).withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Poster image
            Image.network(
              iklan.poster.startsWith('http')
                  ? iklan.poster
                  : ApiEndpoints.baseUrl +
                      ApiEndpoints.authendpoints.getImageIklan +
                      iklan.poster,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C4E40), Color(0xFF1E352B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Left gradient for legibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
            // Title + CTA
            Positioned(
              left: 20,
              bottom: 20,
              right: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    iklan.judul,
                    style: AppColors.fontStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Belanja Sekarang",
                      style: AppColors.fontStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2F2828),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fallback banner with brand gradient + local asset image
  Widget _buildFallbackBannerItem(Map<String, dynamic> banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF2C4E40), Color(0xFF1E352B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C4E40).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        banner['title'] as String,
                        style: AppColors.fontStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        banner['subtitle'] as String,
                        style: AppColors.fontStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC107),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Belanja Sekarang",
                          style: AppColors.fontStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2F2828),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.transparent, Colors.black],
                        stops: [0.0, 0.4],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      banner['image'] as String,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Featured Products ────────────────────────────────────────────────────────

  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured Products",
                style: AppColors.fontStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2F2828),
                  letterSpacing: -0.3,
                ),
              ),
              InkWell(
                onTap: () => pageController.setPageIndex(1),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  child: Text(
                    "Lihat Semua",
                    style: AppColors.fontStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C4E40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Reactive grid — uses listProdukHome (rekomendasi endpoint)
        Obx(() {
          if (apiProduk.isLoadingHome.value) {
            return _buildProductShimmer();
          }

          final listProduk = apiProduk.listProdukHome;

          if (listProduk.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.inventory_2_outlined,
                        size: 56, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      "Belum ada produk tersedia",
                      style: AppColors.fontStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final displayCount = listProduk.length > 6 ? 6 : listProduk.length;

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: displayCount,
            itemBuilder: (context, index) {
              final p = listProduk[index];
              return ProdukTerlarisDashboard(
                image: p.image,
                namaProduk: p.namaProduk,
                harga: p.harga.toString(),
                rating: p.rating.toString(),
                stok: p.stok,
                jumlahReview: p.jumlahReview,
                isFavorite: p.isFavorite,
                aksi: () {
                  Get.to(const LayoutDetailProduct(), arguments: {
                    'idToko': p.idUser,
                    'idProduk': p.idProduk,
                    'namaProduk': p.namaProduk,
                    'fotoProduk': p.image,
                    'namaToko': p.namaToko,
                  });
                },
                aksiKeranjang: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return BottomSheetProduk(
                        image: p.image,
                        namaProduk: p.namaProduk,
                        harga: p.harga.toString(),
                        idProduk: p.idProduk,
                        idToko: p.idUser,
                        namaToko: p.namaToko,
                      );
                    },
                  );
                },
              );
            },
          );
        }),
      ],
    );
  }

  /// Skeleton shimmer untuk grid produk saat loading
  Widget _buildProductShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: 4,
      itemBuilder: (context, index) =>
          _ShimmerBox(borderRadius: BorderRadius.circular(16)),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  Widget _buildSectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: AppColors.fontStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF2F2828),
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

// ── Shimmer placeholder ────────────────────────────────────────────────────────

class _ShimmerBox extends StatefulWidget {
  final BorderRadius borderRadius;
  const _ShimmerBox({required this.borderRadius});

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 0.9).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) => Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: Color.lerp(
            Colors.grey.shade200,
            Colors.grey.shade100,
            _anim.value,
          ),
        ),
      ),
    );
  }
}
