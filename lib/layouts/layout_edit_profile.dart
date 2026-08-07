import 'package:project_camp_sewa/theme_colors.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_camp_sewa/components/input/input_versi1.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/models/user.dart';
import 'package:project_camp_sewa/services/api_data_user.dart';

class LayoutEditProfile extends StatefulWidget {
  const LayoutEditProfile({super.key});

  @override
  State<LayoutEditProfile> createState() => _LayoutEditProfileState();
}

class _LayoutEditProfileState extends State<LayoutEditProfile> {
  ApiDataUser apiDataUser = Get.put(ApiDataUser());
  XFile? pickedPhotoProfile;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        apiDataUser.tanggalLahirController.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apiDataUser.getDataUser(context);
  }

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
                            "Edit Profile",
                            style: AppColors.fontStyle(fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                final User? dataUser = apiDataUser.dataUser.value;
                if (dataUser != null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: pickedPhotoProfile != null
                              ? FileImage(File(pickedPhotoProfile!.path))
                              : NetworkImage(ApiEndpoints.baseUrl +
                                  ApiEndpoints.authendpoints.getFotoProfile +
                                  dataUser.image!) as ImageProvider,
                        ),
                        Positioned(
                            bottom: 5,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                checkPermissions();
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: const Color(0xFF2F2828)),
                                child: Center(
                                  child: Icon(
                                    MdiIcons.pencilOutline,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      //photo profile
                      radius: 65,
                      backgroundImage: AssetImage("assets/images/error-pp.jpg"),
                    ),
                  );
                }
              }),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 5),
                      child: Text(
                        "Nama",
                        style: AppColors.fontStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InputVersiSatu(
                      controller: apiDataUser.namaController,
                      tipeInput: TextInputType.text,
                      showEyes: false,
                      iconInput: const Icon(Icons.person_outline),
                      placeHolder: "Username",
                      border: true,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 5, top: 10),
                      child: Text(
                        "Email",
                        style: AppColors.fontStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InputVersiSatu(
                      controller: apiDataUser.emailController,
                      tipeInput: TextInputType.emailAddress,
                      showEyes: false,
                      iconInput: const Icon(Icons.email_rounded),
                      placeHolder: "Email",
                      border: true,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 5, top: 10),
                      child: Text(
                        "Nomor Telephone",
                        style: AppColors.fontStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InputVersiSatu(
                      controller: apiDataUser.phoneNumberController,
                      tipeInput: TextInputType.phone,
                      showEyes: false,
                      iconInput: const Icon(Icons.phone),
                      placeHolder: "No.Telephone",
                      border: true,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 5, top: 10),
                      child: Text(
                        "Tanggal Lahir",
                        style: AppColors.fontStyle(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 1.2, color: Colors.black)),
                        child: TextField(
                          controller: apiDataUser.tanggalLahirController,
                          onTap: () {
                            _selectDate(context);
                          },
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.date_range),
                            hintText: "Tanggal Lahir",
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintStyle: AppColors.fontStyle(color: Colors.grey, fontSize: 14),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: () {
                    apiDataUser.updateProfile(context, pickedPhotoProfile);
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF2F2828),
                    ),
                    child: Center(
                      child: Text(
                        "Simpan",
                        style: AppColors.fontStyle(fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  checkPermissions() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.storage,
    ].request();
    if (status[Permission.camera] != PermissionStatus.granted ||
        status[Permission.storage] != PermissionStatus.granted) {
      return;
    }
    pickedImage();
  }

  pickedImage() async {
    final picker = ImagePicker();
    pickedPhotoProfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}
