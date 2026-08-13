import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/components/bottomsheet/bottom_sheet_produk.dart';
import 'package:project_camp_sewa/components/card/produk_terlaris_card.dart';
import 'package:project_camp_sewa/layouts/layout_detail_product.dart';
import 'package:project_camp_sewa/layouts/layout_keranjang.dart';
import 'package:project_camp_sewa/models/produk_model.dart';
import 'package:project_camp_sewa/services/api_produk.dart';
import 'package:project_camp_sewa/services/controller_search.dart';
import 'package:project_camp_sewa/theme_colors.dart';

class LayoutProduct extends StatefulWidget {
  const LayoutProduct({super.key});

  @override
  State<LayoutProduct> createState() => _LayoutProductState();
}

class _LayoutProductState extends State<LayoutProduct> {
  ApiProduk apiProduk = Get.put(ApiProduk());
  TeksSearchController textSearchController = Get.put(TeksSearchController());
  TextEditingController searchController = TextEditingController();

  final List<_KategoriItem> _kategoriList = const [
    _KategoriItem(label: 'Semua', icon: Icons.apps_rounded, param: ''),
    _KategoriItem(
        label: 'Rekomendasi',
        icon: Icons.thumb_up_rounded,
        param: 'rekomendasi'),
    _KategoriItem(
        label: 'Terbaru', icon: Icons.fiber_new_rounded, param: 'terbaru'),
    _KategoriItem(
        label: 'Termurah',
        icon: Icons.trending_down_rounded,
        param: 'termurah'),
    _KategoriItem(
        label: 'Termahal',
        icon: Icons.workspace_premium_rounded,
        param: 'termahal'),
    _KategoriItem(label: 'Tenda', icon: Icons.house_rounded, param: 'tenda'),
    _KategoriItem(
        label: 'Pakaian', icon: Icons.checkroom_rounded, param: 'pakaian'),
    _KategoriItem(
        label: 'Peralatan', icon: Icons.build_rounded, param: 'peralatan'),
  ];

  String filterKategoriLabel = 'Semua';
  String filterKategoriParam = '';

  // Separate loading state for this page's product list
  final RxBool _isLoading = true.obs;

  Timer? _debounce;
  Worker? _searchWorker;

  // ── Data fetching ────────────────────────────────────────────────────────────

  void _fetchData() async {
    _isLoading.value = true;
    await apiProduk.getProduk(
      context,
      textSearchController.searchTeks.value.isEmpty
          ? null
          : textSearchController.searchTeks.value,
      filterKategoriParam.isEmpty ? null : filterKategoriParam,
    );
    _isLoading.value = false;
  }

  void _filterProduk(String label, String param) {
    setState(() {
      filterKategoriLabel = label;
      filterKategoriParam = param;
    });
    _fetchData();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      textSearchController.searchTeks.value = query;
      _fetchData();
    });
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    searchController.text = textSearchController.searchTeks.value;

    _searchWorker = ever(textSearchController.searchTeks, (value) {
      if (searchController.text != value) searchController.text = value;
    });

    _fetchData();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchWorker?.dispose();
    searchController.dispose();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
    super.dispose();
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: Column(
          children: [
            // ── 1. HEADER (green bar) ─────────────────────────────────
            _buildHeader(),

            // ── 2. SEARCH BAR ─────────────────────────────────────────
            _buildSearchBar(),

            // ── 3. CATEGORY CHIPS ─────────────────────────────────────
            _buildCategoryChips(),

            // ── 4. RESULTS HEADER + 5. PRODUCT GRID (scrollable) ──────
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildResultsHeader()),
                  _buildProductGrid(),
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // 1. HEADER
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF2C4E40),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 20,
        right: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Produk",
                  style: AppColors.fontStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.4,
                  ),
                ),
                Text(
                  "Peralatan Camping Terlengkap",
                  style: AppColors.fontStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Get.to(const LayoutKeranjang()),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.shopping_cart_rounded,
                    color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // 2. SEARCH BAR  (below header, above chips)
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildSearchBar() {
    return Container(
      // Continues the green background behind the search bar
      color: const Color(0xFF2C4E40),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2C4E40),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.search_rounded,
                  color: Colors.white, size: 20),
            ),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: _onSearchChanged,
                style: AppColors.fontStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2F2828),
                ),
                decoration: InputDecoration(
                  hintText: "Cari peralatan camping...",
                  hintStyle: AppColors.fontStyle(
                    color: const Color(0xFFBDBDBD),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: searchController,
              builder: (context, child) {
                return searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded,
                            size: 20, color: Color(0xFFBDBDBD)),
                        onPressed: () {
                          searchController.clear();
                          textSearchController.searchTeks.value = '';
                          _fetchData();
                        },
                      )
                    : const SizedBox(width: 16);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // 3. CATEGORY CHIPS  (below search bar, above grid)
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildCategoryChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          // clipBehavior: Clip.none so shadows are not cut off
          clipBehavior: Clip.none,
          itemCount: _kategoriList.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final item = _kategoriList[index];
            final isSelected = filterKategoriLabel == item.label;
            return GestureDetector(
              onTap: () => _filterProduk(item.label, item.param),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2C4E40)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2C4E40)
                        : Colors.grey.shade300,
                    width: 1.2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color:
                                const Color(0xFF2C4E40).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 13,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF9E9E9E),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.label,
                      style: AppColors.fontStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF9E9E9E),
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

  // ══════════════════════════════════════════════════════════════════════════════
  // 4. RESULTS HEADER  (count + sort button)
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildResultsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filterKategoriLabel == 'Semua'
                    ? 'Semua Produk'
                    : filterKategoriLabel,
                style: AppColors.fontStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2F2828),
                ),
              ),
              Obx(() {
                final count = apiProduk.listProduk.length;
                return Text(
                  "$count produk tersedia",
                  style: AppColors.fontStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFBDBDBD),
                  ),
                );
              }),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                const Icon(Icons.swap_vert_rounded,
                    size: 16, color: Color(0xFFBDBDBD)),
                const SizedBox(width: 5),
                Text(
                  "Urutkan",
                  style: AppColors.fontStyle(
                    fontSize: 12,
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

  // ══════════════════════════════════════════════════════════════════════════════
  // 5. PRODUCT GRID
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildProductGrid() {
    return Obx(() {
      // Show shimmer while loading
      if (_isLoading.value) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, __) => _ShimmerCard(),
              childCount: 6,
            ),
          ),
        );
      }

      final listProduk = apiProduk.listProduk;

      // Empty state — only shown after loading completes
      if (listProduk.isEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search_off_rounded,
                      size: 44,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Produk tidak ditemukan",
                    style: AppColors.fontStyle(
                      color: const Color(0xFF2F2828),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Coba kata kunci atau kategori lain",
                    style: AppColors.fontStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      searchController.clear();
                      textSearchController.searchTeks.value = '';
                      _filterProduk('Semua', '');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C4E40),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Reset Filter",
                        style: AppColors.fontStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      // Product grid
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final ProdukModel p = listProduk[index];
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
            childCount: listProduk.length,
          ),
        ),
      );
    });
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Shimmer card placeholder
// ══════════════════════════════════════════════════════════════════════════════

class _ShimmerCard extends StatefulWidget {
  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.25, end: 0.9).animate(
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
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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

// ══════════════════════════════════════════════════════════════════════════════
// Kategori item model
// ══════════════════════════════════════════════════════════════════════════════

class _KategoriItem {
  final String label;
  final IconData icon;
  final String param;
  const _KategoriItem(
      {required this.label, required this.icon, required this.param});
}
