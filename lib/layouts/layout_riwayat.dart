import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:project_camp_sewa/components/card/riwayat_card.dart';
import 'package:project_camp_sewa/models/riwayat_model.dart';

class LayoutRiwayat extends StatefulWidget {
  final List<RiwayatModel> riwayatData;
  const LayoutRiwayat({super.key, required this.riwayatData});

  @override
  State<LayoutRiwayat> createState() => _LayoutRiwayatState();
}

class _LayoutRiwayatState extends State<LayoutRiwayat> {
  late List<RiwayatModel> listRiwayat;

  @override
  void initState() {
    listRiwayat = widget.riwayatData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listRiwayat.isEmpty) {
      return Container(
        color: const Color(0xFFFFFFFF),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F2828).withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  size: 64,
                  color: Color(0xFF2F2828),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Belum ada pesanan",
                style: AppColors.fontStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2F2828),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Pesanan kamu akan muncul di sini",
                style: AppColors.fontStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              RiwayatModel list = listRiwayat[index];
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: RiwayatCard(
                  namaToko: list.namaToko,
                  fotoProduk: list.fotoProduk,
                  namaProduk: list.namaProduk,
                  variasiWarna: list.warna,
                  variasiUkuran: list.ukuran,
                  qty: list.qty,
                  harga: list.harga,
                  totalPesanan: list.totalPesanan,
                  qtyProdukLain: list.qtyProdukLain,
                  rating: list.rating,
                  hari: list.hari,
                  statusTransaksi: list.statusTransaksi,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
            itemCount: listRiwayat.length),
      ),
    );
  }
}
