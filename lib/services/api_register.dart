// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/components/dialog/alert_dialog.dart';
import 'package:project_camp_sewa/components/dialog/loading_dialog.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/screens/screen_login.dart';

class ApiRegistrasi extends GetxController {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  final Dio dio = Dio();
  final LoadingDialog loading = Get.put(LoadingDialog());

  Future<void> registrasi(BuildContext context) async {
    try {
      loading.showLoadingDialog();
      var header = {'Content-Type': 'application/json'};
      var url = ApiEndpoints.baseUrl + ApiEndpoints.authendpoints.register;
      Map body = {
        'name': namaController.text,
        'email': emailController.text.trim(),
        'nomor_telephone': phoneNumberController.text,
        'password': passwordController.text,
        'tanggal_lahir': tanggalLahirController.text
      };

      final response = await dio.post(url,
          data: body,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! < 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      loading.hideLoadingDialog();

      if (response.statusCode == 201) {
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: true,
              teks: json['message'],
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        namaController.clear();
        emailController.clear();
        phoneNumberController.clear();
        passwordController.clear();
        tanggalLahirController.clear();
        if (context.mounted) {
          Get.to(const LoginScreen());
        }
      } else{
        String errorMessage = json['error'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        loading.hideLoadingDialog();
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: CustomAlertDialog(
                    sukses: false,
                    teks: dioError.message ?? "An unknown error occurred",
                  ),
                );
              });
        }
      }
    }
  }
}

