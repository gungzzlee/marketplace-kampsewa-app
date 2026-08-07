class ApiEndpoints {
  static const String baseUrl = "http://192.168.0.2:8000";
  static AuthEndPoints authendpoints = AuthEndPoints();
}

class AuthEndPoints {
  final String getFotoProfile = "/assets/image/customers/profile/";
  final String getImageIklan = "/assets/image/customers/advert/";
  final String getImageProduk = "/assets/image/customers/produk/";
  final String login = "/api/login";
  final String register = "/api/register";
  final String lupaPass = "/api/lupa-password";
  final String lupaPassOTP = "/api/lupa-password/verifikasi-otp/";
  final String lupaPassResetPass = "/api/lupa-password/reset-password/";
  final String lupaPassKirimUlangOTP = "/api/lupa-password/kirim-ulang-otp/";
  final String getDataUser = "/api/user/";
  final String isiDataToko = "/api/user/input-store/";
  final String updateDataUser = "/api/user/update-profile/";
  final String tambahAlamatUser = "/api/user/tambah-alamat";
  final String getAlamatUser = "/api/user/list-alamat/";
  final String updateAlamatUser = "/api/user/update-alamat/";
  final String deleteAlamatUser = "/api/user/delete-alamat/";
  final String tambahBankMetodeTransfer = "/api/user/tambah-bank/";
  final String getIklan = "/api/iklan";
  final String getProdukRatingTertinggi =
      "/api/produk/produk-rating-tertinggi-limit6";
  final String getProduk = "/api/produk/";
  final String getProdukBottomSheet = "/api/produk/detail-keranjang-produk/";
  final String getDetailProduk = "/api/produk/detail-produk/";
  final String insertRiwayatCari = "/api/riwayat-pencarian/insert/";
  final String showRiwayatCari = "/api/riwayat-pencarian/show/";
  final String deleteRiwayatCari = "/api/riwayat-pencarian/delete/";
  final String transaksiCheckout = "/api/transaksi/checkout/";
  final String getAlamatTokoCheckout = "/api/transaksi/lokasi-toko";
  final String getBankOpsiPembayaranTransfer = "/api/transaksi/bank-toko";
  final String transaksiPembayaran = "/api/transaksi/pembayaran";
}
