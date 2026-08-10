import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/components/button/opsi_pembayaran.dart';
import 'package:project_camp_sewa/components/button/opsi_pembayaran_transfer.dart';
import 'package:project_camp_sewa/models/bank_model.dart';
import 'package:project_camp_sewa/services/api_transaksi.dart';

class LayoutMetodePembayaran extends StatefulWidget {
  const LayoutMetodePembayaran({super.key});

  @override
  State<LayoutMetodePembayaran> createState() => _LayoutMetodePembayaranState();
}

class _LayoutMetodePembayaranState extends State<LayoutMetodePembayaran> {
  ApiTransaksi apiTransaksi = Get.put(ApiTransaksi());
  String selectedIcon = "assets/icons/selected-opsi-bayar.png";
  String defaultIcon = "assets/icons/default-opsi-bayar.png";
  Color selectedBgColor = const Color(0xFF2F2828);
  Color defaultBgColor = Colors.white;
  Color selectedTextColor = Colors.white;
  Color defaultTextColor = Colors.black;
  String selectedOption = "transfer";
  String? selectedBank;
  String? rekeningBank;

  @override
  void initState() {
    super.initState();
    getListBank();
  }

  Future<void> getListBank() async {
    final arguments = await Get.arguments as Map<String, dynamic>;
    String idToko = arguments['idToko'];
    // ignore: use_build_context_synchronously
    await apiTransaksi.getBankOpsiPembayaran(context, idToko);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                        size: 28,
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4 - 55,
                ),
                Text(
                  "Metode Pembayaran",
                  style: AppColors.fontStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ]),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 20, bottom: 5),
              child: Text(
                "Pilih Metode Pembayaran",
                style: AppColors.fontStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  "Harap membaca syarat & ketentuan saat memilih metode pembayaran",
                  style: AppColors.fontStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              height: 1.5,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedOption = "transfer";
                });
              },
              child: OpsiPembayaran(
                bgColor: selectedOption == "transfer"
                    ? selectedBgColor
                    : defaultBgColor,
                icon: selectedOption == "transfer" ? selectedIcon : defaultIcon,
                teksColor: selectedOption == "transfer"
                    ? selectedTextColor
                    : defaultTextColor,
                checklist: selectedOption == "transfer" ? true : false,
                opsiBayar: "Transfer",
                keterangan:
                    "Pembayaran ini melalui cara transfer dan barang siap untuk dikirim atau diambil di store",
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation);

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
              child: selectedOption == "transfer"
                  ? Column(
                      key: const ValueKey(
                          'ListViewColumn'), // Key untuk mengidentifikasi widget unik
                      children: [
                        Obx(() {
                          List<BankModel> listBank =
                              apiTransaksi.listBankMetodeBayar;
                          return ListView.builder(
                            itemCount: apiTransaksi.listBankMetodeBayar.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              BankModel list = listBank[index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedBank = list.bank;
                                    rekeningBank = list.rekening;
                                  });
                                },
                                child: OpsiPembayaranTransfer(
                                  bank: list.bank,
                                  selected: selectedBank == list.bank,
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    )
                  : const SizedBox(
                      key: ValueKey(
                          'SizedBox')), // Key untuk mengidentifikasi widget unik
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedOption = "COD";
                });
              },
              child: OpsiPembayaran(
                bgColor:
                    selectedOption == "COD" ? selectedBgColor : defaultBgColor,
                icon: selectedOption == "COD" ? selectedIcon : defaultIcon,
                teksColor: selectedOption == "COD"
                    ? selectedTextColor
                    : defaultTextColor,
                checklist: selectedOption == "COD" ? true : false,
                opsiBayar: "COD",
                keterangan:
                    "Pembayaran ini akan dilakukan saat pengambilan barang",
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              height: 1.5,
            ),
            const Spacer(),
            Container(
              height: 2,
              color: Colors.black.withValues(alpha: 0.3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: InkWell(
                onTap: () {
                  Get.back(
                      result: selectedOption == "transfer"
                          ? {
                              'metodeBayar': "Transfer",
                              'jenisBank': "$selectedBank",
                              'rekeningBank': rekeningBank
                            }
                          : {'metodeBayar': "Bayar Ditempat"});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF2F2828),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Konfirmasi",
                        style: AppColors.fontStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
