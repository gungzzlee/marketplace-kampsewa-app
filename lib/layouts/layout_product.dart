import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/components/bottomsheet/bottom_sheet_produk.dart';
import 'package:project_camp_sewa/components/card/produk_terlaris_card.dart';
import 'package:project_camp_sewa/layouts/layout_detail_product.dart';
import 'package:project_camp_sewa/layouts/layout_keranjang.dart';
import 'package:project_camp_sewa/layouts/layout_search_screen.dart';
import 'package:project_camp_sewa/theme_colors.dart';

class LayoutProduct extends StatefulWidget {
  const LayoutProduct({super.key});

  @override
  State<LayoutProduct> createState() => _LayoutProductState();
}

class _LayoutProductState extends State<LayoutProduct>
    with SingleTickerProviderStateMixin {
  // ── Data ──────────────────────────────────────────────────────────────
  final List<_KategoriItem> _kategoriList = const [
    _KategoriItem(label: 'Semua', icon: Icons.apps_rounded),
    _KategoriItem(label: 'Rekomendasi', icon: Icons.thumb_up_rounded),
    _KategoriItem(label: 'Terbaru', icon: Icons.fiber_new_rounded),
    _KategoriItem(label: 'Termurah', icon: Icons.trending_down_rounded),
    _KategoriItem(label: 'Termahal', icon: Icons.workspace_premium_rounded),
    _KategoriItem(label: 'Tenda', icon: Icons.house_rounded),
    _KategoriItem(label: 'Pakaian', icon: Icons.checkroom_rounded),
    _KategoriItem(label: 'Peralatan', icon: Icons.build_rounded),
  ];

  String filterKategori = "Semua";

  final List<Map<String, dynamic>> _allProduk = [
    {'namaProduk': 'Tenda Dome Coleman', 'harga': '75000', 'rating': 4.8, 'image': 'assets/images/tenda-dome-coleman.jpg', 'kategori': 'Tenda', 'namaToko': 'Toko Camping Pro'},
    {'namaProduk': 'Tenda Hammock', 'harga': '55000', 'rating': 4.5, 'image': 'assets/images/tenda-hammoc.jpg', 'kategori': 'Tenda', 'namaToko': 'Outdoor Store'},
    {'namaProduk': 'Sleeping Bag', 'harga': '35000', 'rating': 4.6, 'image': 'assets/images/slepping-bag.jpg', 'kategori': 'Perlengkapan', 'namaToko': 'Camp Corner'},
    {'namaProduk': 'Kompor Portable', 'harga': '25000', 'rating': 4.7, 'image': 'assets/images/kompor-portable.jpg', 'kategori': 'Peralatan', 'namaToko': 'Gear Store'},
    {'namaProduk': 'Set Alat Masak', 'harga': '40000', 'rating': 4.4, 'image': 'assets/images/set-alat-masak.jpg', 'kategori': 'Peralatan', 'namaToko': 'Outdoor Store'},
    {'namaProduk': 'Kursi Lipat', 'harga': '20000', 'rating': 4.2, 'image': 'assets/images/kursi-lipat.jpg', 'kategori': 'Perlengkapan', 'namaToko': 'Toko Camping Pro'},
    {'namaProduk': 'Raincoat Marmot', 'harga': '45000', 'rating': 4.9, 'image': 'assets/images/raincoat-marmot.jpg', 'kategori': 'Pakaian', 'namaToko': 'Fashion Camp'},
    {'namaProduk': 'Gaiter', 'harga': '15000', 'rating': 4.1, 'image': 'assets/images/gaiter.jpg', 'kategori': 'Pakaian', 'namaToko': 'Gear Store'},
    {'namaProduk': 'Sepatu Hiking', 'harga': '60000', 'rating': 4.8, 'image': 'assets/images/sepatu-hiking-merrell.jpg', 'kategori': 'Pakaian', 'namaToko': 'Camp Corner'},
    {'namaProduk': 'Survival Kit', 'harga': '30000', 'rating': 4.5, 'image': 'assets/images/survival-kit.jpg', 'kategori': 'Perlengkapan', 'namaToko': 'Outdoor Store'},
    {'namaProduk': 'Cooler Box Igloo', 'harga': '50000', 'rating': 4.3, 'image': 'assets/images/cooler-box-igloo.jpg', 'kategori': 'Peralatan', 'namaToko': 'Gear Store'},
  ];

  List<Map<String, dynamic>> _filteredProduk = [];

  // ── Scroll ─────────────────────────────────────────────────────────────
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  // ── Filter ─────────────────────────────────────────────────────────────
  void _filterProduk(String kategori) {
    setState(() {
      filterKategori = kategori;
      if (['Semua', 'Rekomendasi', 'Terbaru', 'Termurah', 'Termahal']
          .contains(kategori)) {
        _filteredProduk = List.from(_allProduk);
      } else {
        _filteredProduk =
            _allProduk.where((p) => p['kategori'] == kategori).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _filterProduk(filterKategori);
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 10;
      if (scrolled != _isScrolled) {
        setState(() => _isScrolled = scrolled);
      }
    });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
    super.dispose();
  }

  // ── Build ───────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Stack(
          children: [
            // ── Gradient hero header background ──────────────────────
            _buildHeroBackground(),

            // ── Main content ─────────────────────────────────────────
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        // Search bar
                        SliverToBoxAdapter(child: _buildSearchBar()),

                        // Category chips
                        SliverToBoxAdapter(child: _buildCategoryChips()),

                        // Results count
                        SliverToBoxAdapter(child: _buildResultsHeader()),

                        // Product grid
                        _buildProductGrid(),

                        // Bottom padding
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 24),
                        ),
                      ],
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

  // ── Hero Background ─────────────────────────────────────────────────────
  Widget _buildHeroBackground() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 220,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1AB783),
              Color(0xFF1AB783), Color(0xFF12825D),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: -40,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 80,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.07),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          // Back button
          Material(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          const Spacer(),

          // Title
          Column(
            children: [
              Text(
                "Produk",
                style: AppColors.fontStyle(fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                "Peralatan Camping Terlengkap",
                style: AppColors.fontStyle(fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Cart button
          Material(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => Get.to(const LayoutKeranjang()),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: GestureDetector(
        onTap: () => Get.to(const LayoutSearchScreen()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1AB783).withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: -4,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1AB783), Color(0xFF12825D)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                "Cari peralatan camping...",
                style: AppColors.fontStyle(color: const Color(0xFFBDBDBD),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                width: 1,
                height: 20,
                color: const Color(0xFFBDBDBD),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.tune_rounded,
                color: Color(0xFFBDBDBD),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Category Chips ──────────────────────────────────────────────────────
  Widget _buildCategoryChips() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: SizedBox(
        height: 44,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: _kategoriList.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final item = _kategoriList[index];
            final isSelected = filterKategori == item.label;
            return GestureDetector(
              onTap: () => _filterProduk(item.label),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            AppColors.colorfulPalette[index % AppColors.colorfulPalette.length],
                            AppColors.colorfulPalette[index % AppColors.colorfulPalette.length].withValues(alpha: 0.7),
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.colorfulPalette[index % AppColors.colorfulPalette.length].withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 15,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFFBDBDBD),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.label,
                      style: AppColors.fontStyle(fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFFBDBDBD),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Results Header ──────────────────────────────────────────────────────
  Widget _buildResultsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filterKategori == 'Semua' ? 'Semua Produk' : filterKategori,
                style: AppColors.fontStyle(fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2F2828),
                ),
              ),
              Text(
                "${_filteredProduk.length} produk tersedia",
                style: AppColors.fontStyle(fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFBDBDBD),
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.swap_vert_rounded,
                  size: 16,
                  color: Color(0xFFBDBDBD),
                ),
                const SizedBox(width: 6),
                Text(
                  "Urutkan",
                  style: AppColors.fontStyle(fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFBDBDBD),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Product Grid ────────────────────────────────────────────────────────
  Widget _buildProductGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.70,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final p = _filteredProduk[index];
            return ProdukTerlarisDashboard(
              image: p['image'],
              namaProduk: p['namaProduk'],
              harga: p['harga'],
              rating: p['rating'].toString(),
              aksi: () {
                Get.to(const LayoutDetailProduct(), arguments: {
                  'idToko': 1,
                  'idProduk': 1,
                  'namaProduk': p['namaProduk'],
                  'fotoProduk': p['image'],
                  'namaToko': p['namaToko'],
                });
              },
              aksiKeranjang: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  builder: (BuildContext context) {
                    return BottomSheetProduk(
                      image: p['image'],
                      namaProduk: p['namaProduk'],
                      harga: p['harga'],
                      idProduk: 1,
                      idToko: 1,
                      namaToko: p['namaToko'],
                    );
                  },
                );
              },
            );
          },
          childCount: _filteredProduk.length,
        ),
      ),
    );
  }
}

// ── Helper model ─────────────────────────────────────────────────────────────
class _KategoriItem {
  final String label;
  final IconData icon;
  const _KategoriItem({required this.label, required this.icon});
}
