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

class _LayoutProductState extends State<LayoutProduct>
    with SingleTickerProviderStateMixin {
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

  String filterKategoriLabel = "Semua";
  String filterKategoriParam = "";

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  Timer? _debounce;

  void _fetchData() {
    apiProduk.getProduk(
        context, textSearchController.searchTeks.value, filterKategoriParam);
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

  Worker? _searchWorker;

  @override
  void initState() {
    super.initState();
    searchController.text = textSearchController.searchTeks.value;

    // Listen to changes in search text from GetX
    _searchWorker = ever(textSearchController.searchTeks, (value) {
      if (searchController.text != value) {
        searchController.text = value;
      }
    });

    _fetchData();

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
    _debounce?.cancel();
    _searchWorker?.dispose();
    _scrollController.dispose();
    searchController.dispose();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
    super.dispose();
  }

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
            _buildHeroBackground(),
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(child: _buildSearchBar()),
                        SliverToBoxAdapter(child: _buildCategoryChips()),
                        SliverToBoxAdapter(child: _buildResultsHeader()),
                        _buildProductGrid(),
                        const SliverToBoxAdapter(child: SizedBox(height: 24)),
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
            colors: [Color(0xFF2C4E40), Color(0xFF2C4E40), Color(0xFF2C4E40)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: Stack(
          children: [
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 40), // Placeholder to keep title centered
          const Spacer(),
          Column(
            children: [
              Text(
                "Produk",
                style: AppColors.fontStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                "Peralatan Camping Terlengkap",
                style: AppColors.fontStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
          const Spacer(),
          Material(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2C4E40).withValues(alpha: 0.12),
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
                    colors: [Color(0xFF2C4E40), Color(0xFF2C4E40)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.search_rounded,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: _onSearchChanged,
                style: AppColors.fontStyle(
                    fontSize: 14, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: "Cari peralatan camping...",
                  hintStyle: AppColors.fontStyle(
                    color: const Color(0xFFBDBDBD),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
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
                          textSearchController.searchTeks.value = "";
                          _fetchData();
                        },
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

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
            final isSelected = filterKategoriLabel == item.label;
            return GestureDetector(
              onTap: () => _filterProduk(item.label, item.param),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(colors: [
                          AppColors.orange,
                          AppColors.orange.withValues(alpha: 0.7)
                        ])
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                              color: AppColors.orange.withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4))
                        ]
                      : [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2))
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 15,
                      color:
                          isSelected ? Colors.white : const Color(0xFFBDBDBD),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.label,
                      style: AppColors.fontStyle(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w600,
                        color:
                            isSelected ? Colors.white : const Color(0xFFBDBDBD),
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
                filterKategoriLabel == 'Semua'
                    ? 'Semua Produk'
                    : filterKategoriLabel,
                style: AppColors.fontStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF2F2828),
                ),
              ),
              Obx(() => Text(
                    "${apiProduk.listProduk.length} produk tersedia",
                    style: AppColors.fontStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFBDBDBD),
                    ),
                  )),
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
                    offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.swap_vert_rounded,
                    size: 16, color: Color(0xFFBDBDBD)),
                const SizedBox(width: 6),
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

  Widget _buildProductGrid() {
    return Obx(() {
      final listProduk = apiProduk.listProduk;
      if (listProduk.isEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.search_off_rounded,
                      size: 60, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    "Produk tidak ditemukan",
                    style: AppColors.fontStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      }

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
              final ProdukModel p = listProduk[index];
              return ProdukTerlarisDashboard(
                image: p.image,
                namaProduk: p.namaProduk,
                harga: p.harga.toString(),
                rating: p.rating.toString(),
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

class _KategoriItem {
  final String label;
  final IconData icon;
  final String param;
  const _KategoriItem(
      {required this.label, required this.icon, required this.param});
}
