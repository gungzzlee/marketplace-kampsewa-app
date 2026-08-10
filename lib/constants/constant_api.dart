const baseUrl = "http://192.168.0.2:8000/api";
const loginUrl = "$baseUrl/login";
const registerUrl = "$baseUrl/register";
const logoutUrl = "$baseUrl/logout";
const allUser = "$baseUrl/alluser";

const serverError = "Server Error";
const unauthorized = "Unauthorized";
const somethingWentWrong = "Terjadi beberapa Error silahkan coba lagi!";
const invalidEmailAndPasswordCombination =
    "Invalid email dan password kombinasi";

String getImageUrl(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return 'https://ui-avatars.com/api/?name=User&background=random';
  }
  if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
    return imageUrl;
  }

  final baseHost = baseUrl.replaceAll('/api', '');

  if (imageUrl.startsWith('/')) {
    imageUrl = imageUrl.substring(1);
  }

  // Hapus 'storage/' dari awal string jika backend mengembalikannya
  if (imageUrl.startsWith('storage/')) {
    imageUrl = imageUrl.substring(8);
  }

  return '$baseHost/$imageUrl';
}
