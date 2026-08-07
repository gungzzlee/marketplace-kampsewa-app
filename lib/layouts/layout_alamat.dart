import 'package:project_camp_sewa/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/components/card/alamat_card.dart';
import 'package:project_camp_sewa/layouts/layout_edit_alamat.dart';
import 'package:project_camp_sewa/models/alamat_model.dart';
import 'package:project_camp_sewa/services/api_data_user.dart';

class LayoutAlamat extends StatefulWidget {
  const LayoutAlamat({super.key});

  @override
  State<LayoutAlamat> createState() => _LayoutAlamatState();
}

class _LayoutAlamatState extends State<LayoutAlamat> {
  ApiDataUser apiDataUser = Get.put(ApiDataUser());

  @override
  void initState() {
    super.initState();
    apiDataUser.getListAlamatUser(context);
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
                  width: MediaQuery.of(context).size.width / 4 - 20,
                ),
                Text(
                  "Alamat Saya",
                  style: AppColors.fontStyle(fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ]),
            ),
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              height: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(() {
                  List<AlamatUserModel> listAlamatUser =
                      apiDataUser.listAlamatUser;
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        AlamatUserModel listAlamat = listAlamatUser[index];
                        return AlamatCard(
                          editAlamat: () {
                            Get.to(LayoutEditAlamat(
                              edit: true,
                              idAlamat: listAlamat.id.toString(),
                              namaLengkap: listAlamat.name,
                              noTelepon: listAlamat.nomorTelephone,
                              ditandaiSebagai: listAlamat.type,
                              latitude: listAlamat.latitude,
                              longitude: listAlamat.longitude,
                              detailAlamat: listAlamat.detailLainnya ?? "",
                            ));
                          },
                          namaUser: listAlamat.name,
                          latitude: listAlamat.latitude,
                          longitude: listAlamat.longitude,
                          noTeleponUser: listAlamat.nomorTelephone,
                          tipeAlamat: listAlamat.type,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: listAlamatUser.length);
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 25, top: 10),
              child: InkWell(
                onTap: () {
                  Get.to(const LayoutEditAlamat(edit: false));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.3),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.plusBox,
                          size: 30,
                          color: Colors.black,
                        ),
                        Text(
                          "Tambah Alamat baru",
                          style: AppColors.fontStyle(fontSize: 17.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
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

