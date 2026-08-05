// ignore_for_file: avoid_print
// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/components/dialog/alert_dialog.dart';
import 'package:project_camp_sewa/components/dialog/loading_dialog.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/screens/screen_dashboard.dart';
import 'package:project_camp_sewa/services/authorization_token.dart';

class ApiLogin extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Dio dio = Dio();
  final LoadingDialog loading = Get.put(LoadingDialog());
  Authorization auth = Authorization();

  Future<void> login(BuildContext context) async {
    try {
      loading.showLoadingDialog();
      var header = {'Content-Type': 'application/json'};
      var url = ApiEndpoints.baseUrl + ApiEndpoints.authendpoints.login;

      Map body = {
        "identifier": emailController.text,
        "password": passwordController.text
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

      if (response.statusCode == 200) {
        if (json['access_token'] != null) {
          var token = json['access_token'];
          var idUser = json['user']['id'];
          // final prefs = await SharedPreferences.getInstance();
          // await prefs.setString('token', token);
          // await prefs.setInt('idUser', idUser);
          auth.saveToken(token);
          auth.saveId(idUser);
          emailController.clear();
          passwordController.clear();

          final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: CustomSnackBar(
                sukses: true,
                teks: "Login Berhasil Sebagai ${json['user']['name']}",
              ));

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          if (context.mounted) {

            Get.off(const ScreenDashboard());
          }
        } else {
          const snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: CustomSnackBar(
                sukses: false,
                teks: "Anda tidak memiliki akses untuk Login",
              ));

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      } else if (response.statusCode == 401) {
        String errorMessage = json['message'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              title: "Error",
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      loading.hideLoadingDialog();
      print(dioError.message);
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

