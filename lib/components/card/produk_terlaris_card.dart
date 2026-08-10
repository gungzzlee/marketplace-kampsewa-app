import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';

class ProdukTerlarisDashboard extends StatefulWidget {
  final String image;
  final String namaProduk;
  final String harga;
  final String rating;
  final Function() aksi;
  final Function() aksiKeranjang;
  const ProdukTerlarisDashboard(
      {super.key,
      required this.image,
      required this.namaProduk,
      required this.harga,
      required this.rating,
      required this.aksi,
      required this.aksiKeranjang});

  @override
  State<ProdukTerlarisDashboard> createState() =>
      _ProdukTerlarisDashboardState();
}

class _ProdukTerlarisDashboardState extends State<ProdukTerlarisDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnim;

  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter = NumberFormat.decimalPattern('id');
    return formatter.format(number);
  }

  String formatRating(String numberString) {
    final number = double.parse(numberString);
    return number.toStringAsFixed(1);
  }

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _pressController.forward();
      },
      onTapUp: (_) {
        _pressController.reverse();
        widget.aksi();
      },
      onTapCancel: () {
        _pressController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 170, // Required for horizontal list view
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2C4E40).withValues(alpha: 0.10),
                offset: const Offset(0, 8),
                blurRadius: 24,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                offset: const Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Image Section ──────────────────────────────────────
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Product image
                      widget.image.startsWith('assets/')
                          ? Image.asset(
                              widget.image,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              ApiEndpoints.baseUrl +
                                  ApiEndpoints.authendpoints.getImageProduk +
                                  widget.image,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFFFFFFF),
                                child: const Icon(
                                  Icons.image_rounded,
                                  color: Color(0xFFFFFFFF),
                                  size: 40,
                                ),
                              ),
                            ),

                      // Gradient overlay (bottom-to-mid)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.38),
                              ],
                              stops: const [0.5, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Rating badge (top-right)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.10),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 13,
                                color: Color(0xFFED6723),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                formatRating(widget.rating),
                                style: AppColors.fontStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2F2828),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // "Sewa" label (top-left)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2C4E40), Color(0xFF2C4E40)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'SEWA',
                            style: AppColors.fontStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Content Section ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.namaProduk,
                        style: AppColors.fontStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2F2828),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Price block
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                    colors: [
                                      Color(0xFF2C4E40),
                                      Color(0xFF2C4E40)
                                    ],
                                  ).createShader(bounds),
                                  child: Text(
                                    "Rp ${formatCurrency(widget.harga)}",
                                    style: AppColors.fontStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "/hari",
                                  style: AppColors.fontStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFBDBDBD),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Add to cart button
                          GestureDetector(
                            onTap: widget.aksiKeranjang,
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF2C4E40),
                                    Color(0xFF2C4E40),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2C4E40)
                                        .withValues(alpha: 0.4),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add_shopping_cart_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
