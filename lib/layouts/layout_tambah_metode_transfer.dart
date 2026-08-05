import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_camp_sewa/services/api_data_user.dart';

class LayoutTambahMetodeTransfer extends StatefulWidget {
  const LayoutTambahMetodeTransfer({super.key});

  @override
  State<LayoutTambahMetodeTransfer> createState() =>
      _LayoutTambahMetodeTransferState();
}

class _LayoutTambahMetodeTransferState
    extends State<LayoutTambahMetodeTransfer> {
  ApiDataUser apiDataUser = Get.put(ApiDataUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
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
                            "Tambah Metode Transfer",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  "assets/images/kartu-metode-pembayaran.png",
                  scale: 2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 5),
                    child: Text(
                      "Nama",
                      style: GoogleFonts.poppins(
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
                          //controller: namaLengkapController,
                          decoration: InputDecoration(
                              hintText: "Atas Nama",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.5, fontWeight: FontWeight.w500),
                              border: InputBorder.none),
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 5),
                    child: Text(
                      "No Rekening",
                      style: GoogleFonts.poppins(
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
                          controller: apiDataUser.noRekController,
                          decoration: InputDecoration(
                              hintText: "Nomor Rekening",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.5, fontWeight: FontWeight.w500),
                              border: InputBorder.none),
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 5),
                    child: Text(
                      "Jenis Bank",
                      style: GoogleFonts.poppins(
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
                          controller: apiDataUser.jenisBankController,
                          decoration: InputDecoration(
                              hintText: "Jenis Bank / Dompet Digital",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14.5, fontWeight: FontWeight.w500),
                              border: InputBorder.none),
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 25),
                child: InkWell(
                  onTap: () {
                    //simpan
                    apiDataUser.tambahBankMetodeTransfer(context);
                  },
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF010935)),
                    child: Center(
                      child: Text(
                        "Simpan",
                        style: GoogleFonts.poppins(
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
        ),
      )),
    );
  }
}

