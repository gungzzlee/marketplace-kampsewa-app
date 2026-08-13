import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/theme_colors.dart';

class RekomendasiCariCard extends StatefulWidget {
  final String image;
  final String namaProduk;
  final String rating;
  final String harga;
  final int stok;
  final int jumlahReview;
  final bool isFavorite;
  final Function() aksi;
  final Function()? aksiFavorite;

  const RekomendasiCariCard({
    super.key,
    required this.image,
    required this.namaProduk,
    required this.rating,
    required this.harga,
    this.stok = 0,
    this.jumlahReview = 0,
    this.isFavorite = false,
    required this.aksi,
    this.aksiFavorite,
  });

  @override
  State<RekomendasiCariCard> createState() => _RekomendasiCariCardState();
}

class _RekomendasiCariCardState extends State<RekomendasiCariCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnim;

  String formatCurrency(String numberString) {
    final number = int.tryParse(numberString) ?? 0;
    final formatter = NumberFormat.decimalPattern('id');
    return formatter.format(number);
  }

  String formatRating(String numberString) {
    final number = double.tryParse(numberString) ?? 0.0;
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
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) {
        _pressController.reverse();
        widget.aksi();
      },
      onTapCancel: () => _pressController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Image Section ──────────────────────────────────────
                AspectRatio(
                  aspectRatio: 1, // 1:1 square image
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Product image — no dark overlay
                      widget.image.startsWith('assets/')
                          ? Image.asset(
                              widget.image,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.image.startsWith('http')
                                  ? widget.image
                                  : ApiEndpoints.baseUrl +
                                      ApiEndpoints.authendpoints
                                          .getImageProduk +
                                      widget.image,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFF0F0F0),
                                child: const Icon(
                                  Icons.image_rounded,
                                  color: Color(0xFFBDBDBD),
                                  size: 40,
                                ),
                              ),
                            ),

                      // Favorite badge (top-right, white circle)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: widget.aksiFavorite,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              widget.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 16,
                              color: widget.isFavorite
                                  ? Colors.red
                                  : const Color(0xFFBDBDBD),
                            ),
                          ),
                        ),
                      ),

                      // Price badge (bottom-left, forest green pill)
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C4E40), // Forest green
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Rp${formatCurrency(widget.harga)}",
                            style: AppColors.fontStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Info Section ──────────────────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Stock label (urgency indicator)
                        Text(
                          widget.stok > 0
                              ? "${widget.stok} Stok Tersisa"
                              : "Stok Habis",
                          style: AppColors.fontStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: widget.stok > 0
                                ? const Color(0xFFED6723) // Orange accent
                                : const Color(0xFFEE2737), // Red for out-of-stock
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Row 2: Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 12,
                              color: Color(0xFFFFC107), // Yellow star
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${formatRating(widget.rating)} (${widget.jumlahReview})",
                              style: AppColors.fontStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF8E8E8E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Row 3: Product name — max 2 lines
                        Expanded(
                          child: Text(
                            widget.namaProduk,
                            style: AppColors.fontStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2F2828),
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
