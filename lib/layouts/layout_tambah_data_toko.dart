import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/components/card/metode_pembayaran_card.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/layouts/layout_tambah_metode_transfer.dart';
import 'package:project_camp_sewa/models/bank_model.dart';
import 'package:project_camp_sewa/services/api_data_user.dart';
import 'package:project_camp_sewa/services/api_transaksi.dart';
import 'package:project_camp_sewa/services/authorization_token.dart';

class LayoutTambahDataToko extends StatefulWidget {
  const LayoutTambahDataToko({super.key});

  @override
  State<LayoutTambahDataToko> createState() => _LayoutTambahDataTokoState();
}

class _LayoutTambahDataTokoState extends State<LayoutTambahDataToko> {
  ApiTransaksi apiTransaksi = Get.put(ApiTransaksi());
  ApiDataUser apiDataUser = Get.put(ApiDataUser());
  TextEditingController alamatController = TextEditingController();
  String? latitude;
  String? longitude;

  @override
  void initState() {
    super.initState();
    getListBank();
  }

  Future<void> getListBank() async {
    Authorization auth = Authorization();
    int? id = await auth.getId();
    String idStr = id.toString();
    // ignore: use_build_context_synchronously
    await apiTransaksi.getBankOpsiPembayaran(context, idStr);
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();

    List<Placemark> placemarks =
        await Geocoding().placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String jalan = placemark.street ?? '';
      String postalCode = placemark.postalCode ?? '';
      String kecamatan = placemark.subLocality ?? '';
      String kabupaten = placemark.locality ?? '';
      String provinsi = placemark.administrativeArea ?? '';
      alamatController.text =
          "$jalan, $kecamatan, $kabupaten, $provinsi, $postalCode";
    } else {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Tidak bisa Mengkonversi koordinat alamat anda",
          ));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
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
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          "Store Saya",
                          style: AppColors.fontStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              height: 2,
            ),
            Expanded(
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 8),
                    child: Text(
                      "Nama Toko",
                      style: AppColors.fontStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: TextField(
                          controller: apiDataUser.namaTokoController,
                          decoration: InputDecoration(
                              hintText: "Nama Tokomu",
                              hintStyle: AppColors.fontStyle(
                                  fontSize: 14.5, fontWeight: FontWeight.w500),
                              border: InputBorder.none),
                          style: AppColors.fontStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 20, right: 20, bottom: 8),
                    child: Text(
                      "Alamat",
                      style: AppColors.fontStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: TextField(
                                  controller: alamatController,
                                  enabled: false,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      hintText:
                                          "Provinsi, Kota, Kecamatan, Kode Pos",
                                      hintStyle: AppColors.fontStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                      border: InputBorder.none),
                                  style: AppColors.fontStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: InkWell(
                            onTap: () {
                              //get location
                              getLocation();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF2F2828),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  child: Text(
                                    "Ambil\nLokasimu",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: AppColors.fontStyle(
                                        fontSize: 10,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: TextField(
                          controller: apiDataUser.detailAlamatTokoController,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText:
                                  "Detail Lainnya (Contoh: {Nama Jalan, Blok, No Rumah)",
                              hintStyle: AppColors.fontStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              border: InputBorder.none),
                          style: AppColors.fontStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 30, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Metode Pembayaran",
                          style: AppColors.fontStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            //ke tambah metode pembayaran
                            Get.to(const LayoutTambahMetodeTransfer());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFF2F2828),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
                              child: Row(
                                children: [
                                  Text(
                                    "Tambah",
                                    style: AppColors.fontStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const CardMetodePembayaran(
                      metodePembayaran: "COD",
                      bank: "Pembayaran dengan uang cash",
                      noRek: "Default"),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    var listBank = apiTransaksi.listBankMetodeBayar;
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          BankModel list = listBank[index];
                          return CardMetodePembayaran(
                            metodePembayaran: "Transfer",
                            bank: list.bank,
                            noRek: list.rekening,
                            edit: () {
                              //ke Edit metode Transfer
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 5,
                            ),
                        itemCount: listBank.length);
                  }),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    color: Colors.black.withValues(alpha: 0.25),
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    child: InkWell(
                      onTap: () {
                        //direct ke website
                        if (apiDataUser.namaTokoController.text.isNotEmpty) {
                          if (latitude != null && longitude != null) {
                            apiDataUser.isiDataToko(
                                context, latitude!, longitude!);
                          } else {
                            const snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: CustomSnackBar(
                                  sukses: false,
                                  title: "Gagal Menyimpan Data",
                                  teks: "Masukkan Alamat Anda Terlebih Dahulu",
                                ));

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        } else {
                          const snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: CustomSnackBar(
                                sukses: false,
                                title: "Gagal Menyimpan Data",
                                teks: "Masukkan Nama Toko Terlebih Dahulu",
                              ));

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF2F2828)),
                        child: Center(
                          child: Text(
                            "Lanjutkan",
                            style: AppColors.fontStyle(
                                fontSize: 18.5,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
