import 'package:project_camp_sewa/theme_colors.dart';
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/components/card/group_produk_keranjang.dart';
import 'package:project_camp_sewa/components/dialog/alert_dialog.dart';
import 'package:project_camp_sewa/layouts/layout_checkout.dart';
import 'package:project_camp_sewa/services/controller_keranjang.dart';

class LayoutKeranjang extends StatefulWidget {
  const LayoutKeranjang({super.key});

  @override
  State<LayoutKeranjang> createState() => _LayoutKeranjangState();
}

class _LayoutKeranjangState extends State<LayoutKeranjang> {
  KeranjangController keranjangController = Get.put(KeranjangController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    keranjangController.getUniqueStores(context);
    keranjangController.updateTotalHargaKeranjang(context);
    keranjangController.updateTotalItemKeranjang(context);
    keranjangController.getSelectedTokoCheckout(context);
  }

  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter = NumberFormat.decimalPattern('id');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.only(top: 8, bottom: 14, left: 4, right: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF2C4E40),
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Keranjang',
                      textAlign: TextAlign.center,
                      style: AppColors.fontStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2C4E40),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  // Placeholder to center title
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // ── Cart items list ──
            Expanded(
              child: Obx(() {
                final stores = keranjangController.uniqueStores;
                if (stores.isEmpty) {
                  return _buildEmptyState();
                }
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final store = stores[index];
                    return GroupProdukKeranjang(
                      namaToko: store['nama_toko'],
                      idToko: store['id_toko'],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: stores.length,
                );
              }),
            ),

            // ── Summary & Checkout footer ──
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Total Item row
                  Row(
                    children: [
                      Text(
                        'Total Item',
                        style: AppColors.fontStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const Spacer(),
                      Obx(() => Text(
                            '${keranjangController.totalItemKeranjang.value} Item',
                            style: AppColors.fontStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2C4E40),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Total harga row
                  Row(
                    children: [
                      Text(
                        'Total Harga',
                        style: AppColors.fontStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Obx(() => Text(
                            'Rp ${formatCurrency(keranjangController.totalHargaKeranjang.value.toString())}',
                            style: AppColors.fontStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2C4E40),
                            ),
                          )),
                      Text(
                        '/hari',
                        style: AppColors.fontStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Checkout button
                  GestureDetector(
                    onTap: () async {
                      await keranjangController
                          .getSelectedTokoCheckout(context);
                      final int totalToko =
                          keranjangController.totalSelectedTokoCheckout.value;
                      if (totalToko == 1) {
                        Get.to(const LayoutCheckout());
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: CustomAlertDialog(
                              sukses: false,
                              title: 'Maaf Atas Ketidaknyamanannya',
                              teks:
                                  'Anda Hanya Bisa Checkout Produk Pada 1 Toko Yang Sama',
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF2C4E40),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF2C4E40).withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Checkout',
                          style: AppColors.fontStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF2C4E40).withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 50,
              color: Color(0xFF2C4E40),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Keranjang Masih Kosong',
            style: AppColors.fontStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan produk ke keranjang\nuntuk mulai berbelanja',
            textAlign: TextAlign.center,
            style: AppColors.fontStyle(
              fontSize: 13,
              color: Colors.black45,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFF2C4E40),
              ),
              child: Text(
                'Cari Produk',
                style: AppColors.fontStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
