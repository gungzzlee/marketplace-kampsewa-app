import 'package:project_camp_sewa/constants/constant_api.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? nomorTelephone;
  String? tanggalLahir;
  String? namaStore;
  bool? isToko;

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.nomorTelephone,
      this.namaStore,
      this.isToko,
      this.tanggalLahir});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
    id : json['id'],
    name : json['name'],
    email : json['email'],
    image : getImageUrl(json['foto']),
    nomorTelephone : json['nomor_telephone'],
    tanggalLahir : json['tanggal_lahir'],
    namaStore : json['name_store'],
    isToko : json['is_toko']);
  }
}
