# 🏕️ KampSewa — Camping Equipment Rental Marketplace

> **A mobile marketplace application for renting camping equipment across Indonesia, built with Flutter.**

KampSewa is a full-featured mobile marketplace that connects camping enthusiasts with equipment rental providers across Indonesia. Users can browse, rent, and pay for camping gear — from tents and sleeping bags to cooking tools — all within a seamless, modern mobile experience. The app communicates with a dedicated REST API backend and uses local SQLite storage for cart management.

---

## 📱 Screenshots & App Flow

```
Splash Screen → Onboarding → Login / Register → Dashboard (Home | Products | History | Profile)
                                                       ↓
                                           Product Detail → Add to Cart
                                                       ↓
                                        Cart → Checkout → Shipping Options
                                                       ↓
                                        Payment Method → Payment Confirmation
                                                       ↓
                                              Transaction History
```

---

## ✨ Features

### 🔐 Authentication
- **Login** with email and password (token-based via REST API)
- **Register** new user accounts
- **Forgot Password** with OTP email verification and password reset flow
- Persistent session using `SharedPreferences` — users stay logged in across app restarts

### 🏠 Dashboard (Home)
- **Animated splash screen** with brand logo and team credit
- **Onboarding screen** with swipeable introduction slides
- **Advertisement banners** (Iklan) fetched from the API
- **Top-rated products** carousel — top 6 by rating
- Navigation via **Google Navigation Bar** (Home, Products, History, Profile)

### 🛍️ Product Catalog
- Full product listing with search functionality
- **Search history** (saved to API and displayed per user)
- **Product detail page** with image, description, price, rating, and store info
- **Variant selection** — color and size options before adding to cart

### 🛒 Shopping Cart
- **Local SQLite cart** (`keranjang.db`) — works offline
- Grouped by store (`id_toko` / `nama_toko`)
- Product selection for partial checkout
- Real-time total price calculation
- Add, update, and remove individual items or clear entire cart

### 📦 Checkout & Ordering
- **Checkout flow** with selected cart items
- **Shipping options** selection per store
- **Store address** display using Geocoding (coordinates → human-readable address)
- **Payment method** selection (bank transfer)
- **Bank / transfer method** details fetched from the API
- Transaction submission to the backend

### 📋 Transaction History
- View all past rental transactions
- Order detail / `rincian pesanan` screen with full breakdown

### 👤 User Profile
- View and **edit profile** (name, phone, profile photo via image picker)
- **Address management** — add, edit, delete delivery addresses
- **Store registration** (`tambah data toko`) — users can become vendors
- **Add bank transfer method** for receiving payments
- Profile photo upload with permission handling

### 📰 Tourism & News
- Wisata (tourism destination) data model
- Berita (news/articles) data model
- Advertising/iklan integration on the home screen

---

## 🏗️ Project Architecture

The project follows a **feature-layered architecture** organized under `lib/`:

```
lib/
├── main.dart                    # App entry point, route definitions (GetMaterialApp)
├── screens/                     # Top-level screen containers
│   ├── splash_screen.dart       # Splash + auto-login check
│   ├── get_started.dart         # Landing/intro page
│   ├── screen_dashboard.dart    # Bottom nav shell (Home/Products/History/Profile)
│   ├── screen_login.dart        # Login screen container
│   ├── screen_register.dart     # Register screen container
│   └── screen_riwayat.dart      # Transaction history container
├── layouts/                     # Full page UI layouts
│   ├── layout_dashboard.dart    # Home feed (banners, top products)
│   ├── layout_product.dart      # Product listing
│   ├── layout_detail_product.dart  # Product detail
│   ├── layout_search_screen.dart   # Search with history
│   ├── layout_keranjang.dart    # Shopping cart
│   ├── layout_checkout.dart     # Checkout process
│   ├── layout_opsi_pengiriman.dart # Shipping options
│   ├── layout_metode_pembayaran.dart # Payment method
│   ├── layout_pembayaran.dart   # Payment confirmation
│   ├── layout_rincian_pesanan.dart  # Order detail
│   ├── layout_riwayat.dart      # Transaction history list
│   ├── layout_profile.dart      # User profile
│   ├── layout_edit_profile.dart # Edit profile
│   ├── layout_alamat.dart       # Address list
│   ├── layout_edit_alamat.dart  # Add/edit address
│   ├── layout_tambah_data_toko.dart # Store registration
│   ├── layout_tambah_metode_transfer.dart # Add bank method
│   ├── layout_login.dart        # Login form
│   ├── layout_register.dart     # Registration form
│   ├── layout_onboarding.dart   # Onboarding slides
│   ├── layout_lupa_password.dart       # Forgot password (email)
│   ├── layout_lupa_password_otp.dart   # OTP verification
│   └── layout_lupa_password_new_pass.dart # New password form
├── models/                      # Data models (JSON deserialization)
│   ├── user.dart
│   ├── produk_model.dart
│   ├── detail_produk_model.dart
│   ├── variant_model.dart
│   ├── keranjang_model.dart
│   ├── riwayat_model.dart
│   ├── alamat_model.dart
│   ├── alamat_toko_checkout_model.dart
│   ├── bank_model.dart
│   ├── iklan_model.dart
│   ├── berita_model.dart
│   ├── wisata_model.dart
│   └── api_response.dart        # Unified API response wrapper
├── services/                    # API calls & state controllers
│   ├── api_login.dart           # Login & logout API
│   ├── api_register.dart        # Registration API
│   ├── api_lupa_password.dart   # Forgot password + OTP API
│   ├── api_data_user.dart       # User profile, address, store, bank APIs
│   ├── api_produk.dart          # Product listing & detail APIs
│   ├── api_iklan.dart           # Advertisement API
│   ├── api_transaksi.dart       # Checkout & payment APIs
│   ├── api_riwayat_cari.dart    # Search history API
│   ├── authorization_token.dart # Token management helper
│   ├── controller_dashboard.dart # GetX page index controller
│   ├── controller_keranjang.dart # GetX cart state controller
│   └── controller_search.dart   # GetX search controller
├── constants/
│   ├── api_endpoint.dart        # All API endpoint URLs
│   ├── constant_api.dart        # Base URL and shared constants
│   └── database_helper.dart     # SQLite cart database (CRUD operations)
└── components/                  # Reusable UI widgets
    ├── appbar/
    ├── bottomsheet/
    ├── button/
    ├── buttionanimation/
    ├── card/
    ├── dialog/
    ├── dropdown/
    └── input/
```

---

## 🔌 API Integration

The app connects to a **Laravel REST API** backend. All endpoints are defined in `lib/constants/api_endpoint.dart`.

| Category | Endpoint | Description |
|---|---|---|
| Auth | `POST /api/login` | User login |
| Auth | `POST /api/register` | New user registration |
| Auth | `POST /api/lupa-password` | Request password reset |
| Auth | `POST /api/lupa-password/verifikasi-otp/{token}` | Verify OTP |
| Auth | `POST /api/lupa-password/reset-password/{token}` | Set new password |
| User | `GET /api/user/{id}` | Get user data |
| User | `PUT /api/user/update-profile/{id}` | Update profile |
| User | `POST /api/user/tambah-alamat` | Add address |
| User | `GET /api/user/list-alamat/{id}` | List user addresses |
| User | `PUT /api/user/update-alamat/{id}` | Update address |
| User | `DELETE /api/user/delete-alamat/{id}` | Delete address |
| User | `POST /api/user/input-store/{id}` | Register as vendor |
| User | `POST /api/user/tambah-bank/{id}` | Add bank method |
| Product | `GET /api/produk/` | All products |
| Product | `GET /api/produk/produk-rating-tertinggi-limit6` | Top 6 by rating |
| Product | `GET /api/produk/detail-produk/{id}` | Product detail |
| Product | `GET /api/produk/detail-keranjang-produk/{id}` | Product for cart |
| Iklan | `GET /api/iklan` | Advertisement banners |
| Search | `POST /api/riwayat-pencarian/insert/{id}` | Save search history |
| Search | `GET /api/riwayat-pencarian/show/{id}` | Get search history |
| Search | `DELETE /api/riwayat-pencarian/delete/{id}` | Clear search history |
| Transaction | `POST /api/transaksi/checkout/{id}` | Submit checkout |
| Transaction | `GET /api/transaksi/lokasi-toko` | Get store location |
| Transaction | `GET /api/transaksi/bank-toko` | Get store bank options |
| Transaction | `POST /api/transaksi/pembayaran` | Confirm payment |

> **Base URL** is configured in `lib/constants/api_endpoint.dart` → `ApiEndpoints.baseUrl`

---

## 🗃️ Local Database (SQLite)

The app uses **SQLite via `sqflite`** to manage the shopping cart locally, enabling offline add-to-cart functionality.

**Table: `keranjang`**

| Column | Type | Description |
|---|---|---|
| `id` | INTEGER PK | Auto-increment row ID |
| `id_toko` | INTEGER | Store ID |
| `nama_toko` | TEXT | Store name |
| `id_produk` | INTEGER | Product ID |
| `foto_produk` | TEXT | Product image path |
| `nama_produk` | TEXT | Product name |
| `variant_warna` | TEXT | Color variant |
| `variant_ukuran` | TEXT | Size variant |
| `harga` | INTEGER | Unit price |
| `qty` | INTEGER | Quantity |
| `selected` | INTEGER | Checkbox selection (0 or 1) |

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `get` | State management & navigation (GetX) |
| `http` / `dio` | HTTP requests to the REST API |
| `shared_preferences` | Persistent token storage |
| `sqflite` + `path` | Local SQLite cart database |
| `google_fonts` | Custom typography (Poppins) |
| `google_nav_bar` | Bottom navigation bar |
| `carousel_slider` | Product image carousels |
| `smooth_page_indicator` | Onboarding page indicator dots |
| `lottie` | Lottie animation support |
| `image_picker` | Profile/product photo selection |
| `permission_handler` | Runtime permission requests |
| `geolocator` | GPS location access |
| `geocoding` | Convert coordinates to address |
| `url_launcher` | Open external URLs/maps |
| `intl` | Date/currency formatting |
| `dropdown_button2` | Enhanced dropdown widgets |
| `swipeable_button_view` | Swipe-to-confirm button |
| `animated_splash_screen` | Splash screen animation |
| `page_transition` | Page transition animations |
| `flutter_spinkit` | Loading indicators |
| `material_design_icons_flutter` | Extended Material icons |
| `logger` | Debug logging |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.2.6 <4.0.0`
- Dart SDK compatible with Flutter version above
- Android Studio / VS Code with Flutter extension
- A running instance of the KampSewa backend API

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/agungkurniawanid/marketplace-kampsewa-app.git
   cd marketplace-kampsewa-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure the API base URL**

   Open `lib/constants/api_endpoint.dart` and update:
   ```dart
   class ApiEndpoints {
     static const String baseUrl = "http://YOUR_API_SERVER_IP:PORT";
   }
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (requires macOS)
flutter build ios --release
```

---

## 👥 Team

Developed by **TEAM PRODUKTIF4**

---

## 📄 License

This project is private and not published to pub.dev.

---
---

# 🏕️ KampSewa — Marketplace Sewa Alat Camping

> **Aplikasi marketplace mobile untuk menyewa peralatan camping di seluruh Indonesia, dibangun dengan Flutter.**

KampSewa adalah aplikasi marketplace mobile lengkap yang menghubungkan para pecinta camping dengan penyedia sewa peralatan di seluruh Indonesia. Pengguna dapat menelusuri, menyewa, dan membayar perlengkapan camping — mulai dari tenda, sleeping bag, hingga peralatan memasak — semuanya dalam satu pengalaman mobile yang modern dan seamless. Aplikasi berkomunikasi dengan backend REST API dan menggunakan penyimpanan SQLite lokal untuk manajemen keranjang belanja.

---

## 📱 Alur Aplikasi

```
Splash Screen → Onboarding → Login / Register → Dashboard (Home | Produk | Riwayat | Profil)
                                                       ↓
                                         Detail Produk → Tambah ke Keranjang
                                                       ↓
                                     Keranjang → Checkout → Opsi Pengiriman
                                                       ↓
                                     Metode Pembayaran → Konfirmasi Pembayaran
                                                       ↓
                                              Riwayat Transaksi
```

---

## ✨ Fitur Aplikasi

### 🔐 Autentikasi
- **Login** dengan email dan password (berbasis token melalui REST API)
- **Register** akun pengguna baru
- **Lupa Password** dengan verifikasi OTP via email dan reset password
- Sesi persisten menggunakan `SharedPreferences` — pengguna tetap login saat buka ulang aplikasi

### 🏠 Dashboard (Beranda)
- **Splash screen animasi** dengan logo brand dan kredit tim
- **Onboarding screen** dengan slide pengenalan aplikasi
- **Banner iklan** yang diambil dari API
- **Carousel produk rating tertinggi** — 6 produk teratas berdasarkan rating
- Navigasi via **Google Navigation Bar** (Home, Produk, Riwayat, Profil)

### 🛍️ Katalog Produk
- Daftar produk lengkap dengan fitur pencarian
- **Riwayat pencarian** (disimpan ke API dan ditampilkan per pengguna)
- **Halaman detail produk** dengan gambar, deskripsi, harga, rating, dan info toko
- **Pemilihan varian** — pilihan warna dan ukuran sebelum masuk keranjang

### 🛒 Keranjang Belanja
- **Keranjang SQLite lokal** (`keranjang.db`) — dapat digunakan secara offline
- Dikelompokkan berdasarkan toko (`id_toko` / `nama_toko`)
- Seleksi produk untuk checkout sebagian
- Perhitungan total harga secara real-time
- Tambah, ubah, dan hapus item individual atau kosongkan seluruh keranjang

### 📦 Checkout & Pemesanan
- **Alur checkout** dengan item keranjang yang dipilih
- **Pemilihan opsi pengiriman** per toko
- **Tampilan alamat toko** menggunakan Geocoding (koordinat → alamat yang dapat dibaca)
- **Pemilihan metode pembayaran** (transfer bank)
- **Detail bank / metode transfer** diambil dari API
- Pengiriman transaksi ke backend

### 📋 Riwayat Transaksi
- Lihat semua transaksi sewa yang lalu
- Halaman **rincian pesanan** dengan rincian lengkap

### 👤 Profil Pengguna
- Lihat dan **edit profil** (nama, telepon, foto profil via image picker)
- **Manajemen alamat** — tambah, edit, hapus alamat pengiriman
- **Pendaftaran toko** (`tambah data toko`) — pengguna bisa menjadi vendor
- **Tambah metode transfer bank** untuk menerima pembayaran
- Upload foto profil dengan penanganan izin perangkat

### 📰 Wisata & Berita
- Model data wisata (destinasi wisata)
- Model data berita/artikel
- Integrasi iklan/banner di halaman beranda

---

## 🏗️ Arsitektur Proyek

Proyek mengikuti **arsitektur berlapis-fitur** yang diorganisir di bawah `lib/`:

```
lib/
├── main.dart                    # Entry point aplikasi, definisi rute (GetMaterialApp)
├── screens/                     # Kontainer layar tingkat atas
│   ├── splash_screen.dart       # Splash + pengecekan auto-login
│   ├── get_started.dart         # Halaman landing/intro
│   ├── screen_dashboard.dart    # Shell navigasi bawah (Home/Produk/Riwayat/Profil)
│   ├── screen_login.dart        # Kontainer layar login
│   ├── screen_register.dart     # Kontainer layar register
│   └── screen_riwayat.dart      # Kontainer riwayat transaksi
├── layouts/                     # Layout UI halaman penuh
│   ├── layout_dashboard.dart    # Feed beranda (banner, produk teratas)
│   ├── layout_product.dart      # Daftar produk
│   ├── layout_detail_product.dart  # Detail produk
│   ├── layout_search_screen.dart   # Pencarian dengan riwayat
│   ├── layout_keranjang.dart    # Keranjang belanja
│   ├── layout_checkout.dart     # Proses checkout
│   ├── layout_opsi_pengiriman.dart # Opsi pengiriman
│   ├── layout_metode_pembayaran.dart # Metode pembayaran
│   ├── layout_pembayaran.dart   # Konfirmasi pembayaran
│   ├── layout_rincian_pesanan.dart  # Detail pesanan
│   ├── layout_riwayat.dart      # Daftar riwayat transaksi
│   ├── layout_profile.dart      # Profil pengguna
│   ├── layout_edit_profile.dart # Edit profil
│   ├── layout_alamat.dart       # Daftar alamat
│   ├── layout_edit_alamat.dart  # Tambah/edit alamat
│   ├── layout_tambah_data_toko.dart # Pendaftaran toko
│   ├── layout_tambah_metode_transfer.dart # Tambah metode bank
│   ├── layout_login.dart        # Form login
│   ├── layout_register.dart     # Form registrasi
│   ├── layout_onboarding.dart   # Slide onboarding
│   ├── layout_lupa_password.dart       # Lupa password (email)
│   ├── layout_lupa_password_otp.dart   # Verifikasi OTP
│   └── layout_lupa_password_new_pass.dart # Form password baru
├── models/                      # Model data (deserialisasi JSON)
│   ├── user.dart
│   ├── produk_model.dart
│   ├── detail_produk_model.dart
│   ├── variant_model.dart
│   ├── keranjang_model.dart
│   ├── riwayat_model.dart
│   ├── alamat_model.dart
│   ├── alamat_toko_checkout_model.dart
│   ├── bank_model.dart
│   ├── iklan_model.dart
│   ├── berita_model.dart
│   ├── wisata_model.dart
│   └── api_response.dart        # Pembungkus respons API terpadu
├── services/                    # Panggilan API & kontroler state
│   ├── api_login.dart           # API login & logout
│   ├── api_register.dart        # API registrasi
│   ├── api_lupa_password.dart   # API lupa password + OTP
│   ├── api_data_user.dart       # API profil, alamat, toko, bank
│   ├── api_produk.dart          # API daftar & detail produk
│   ├── api_iklan.dart           # API iklan/banner
│   ├── api_transaksi.dart       # API checkout & pembayaran
│   ├── api_riwayat_cari.dart    # API riwayat pencarian
│   ├── authorization_token.dart # Helper manajemen token
│   ├── controller_dashboard.dart # Kontroler index halaman (GetX)
│   ├── controller_keranjang.dart # Kontroler state keranjang (GetX)
│   └── controller_search.dart   # Kontroler pencarian (GetX)
├── constants/
│   ├── api_endpoint.dart        # Semua URL endpoint API
│   ├── constant_api.dart        # Base URL dan konstanta bersama
│   └── database_helper.dart     # Database SQLite keranjang (operasi CRUD)
└── components/                  # Widget UI yang dapat digunakan kembali
    ├── appbar/
    ├── bottomsheet/
    ├── button/
    ├── buttionanimation/
    ├── card/
    ├── dialog/
    ├── dropdown/
    └── input/
```

---

## 🔌 Integrasi API

Aplikasi terhubung ke backend **Laravel REST API**. Semua endpoint didefinisikan di `lib/constants/api_endpoint.dart`.

| Kategori | Endpoint | Keterangan |
|---|---|---|
| Auth | `POST /api/login` | Login pengguna |
| Auth | `POST /api/register` | Registrasi pengguna baru |
| Auth | `POST /api/lupa-password` | Request reset password |
| Auth | `POST /api/lupa-password/verifikasi-otp/{token}` | Verifikasi OTP |
| Auth | `POST /api/lupa-password/reset-password/{token}` | Set password baru |
| Pengguna | `GET /api/user/{id}` | Ambil data pengguna |
| Pengguna | `PUT /api/user/update-profile/{id}` | Update profil |
| Pengguna | `POST /api/user/tambah-alamat` | Tambah alamat |
| Pengguna | `GET /api/user/list-alamat/{id}` | Daftar alamat pengguna |
| Pengguna | `PUT /api/user/update-alamat/{id}` | Update alamat |
| Pengguna | `DELETE /api/user/delete-alamat/{id}` | Hapus alamat |
| Pengguna | `POST /api/user/input-store/{id}` | Daftar sebagai vendor |
| Pengguna | `POST /api/user/tambah-bank/{id}` | Tambah metode bank |
| Produk | `GET /api/produk/` | Semua produk |
| Produk | `GET /api/produk/produk-rating-tertinggi-limit6` | 6 produk rating tertinggi |
| Produk | `GET /api/produk/detail-produk/{id}` | Detail produk |
| Produk | `GET /api/produk/detail-keranjang-produk/{id}` | Produk untuk keranjang |
| Iklan | `GET /api/iklan` | Banner iklan |
| Pencarian | `POST /api/riwayat-pencarian/insert/{id}` | Simpan riwayat pencarian |
| Pencarian | `GET /api/riwayat-pencarian/show/{id}` | Ambil riwayat pencarian |
| Pencarian | `DELETE /api/riwayat-pencarian/delete/{id}` | Hapus riwayat pencarian |
| Transaksi | `POST /api/transaksi/checkout/{id}` | Submit checkout |
| Transaksi | `GET /api/transaksi/lokasi-toko` | Lokasi toko |
| Transaksi | `GET /api/transaksi/bank-toko` | Opsi bank toko |
| Transaksi | `POST /api/transaksi/pembayaran` | Konfirmasi pembayaran |

> **Base URL** dikonfigurasi di `lib/constants/api_endpoint.dart` → `ApiEndpoints.baseUrl`

---

## 🗃️ Database Lokal (SQLite)

Aplikasi menggunakan **SQLite via `sqflite`** untuk mengelola keranjang belanja secara lokal, memungkinkan fitur tambah-ke-keranjang secara offline.

**Tabel: `keranjang`**

| Kolom | Tipe | Keterangan |
|---|---|---|
| `id` | INTEGER PK | ID baris auto-increment |
| `id_toko` | INTEGER | ID toko |
| `nama_toko` | TEXT | Nama toko |
| `id_produk` | INTEGER | ID produk |
| `foto_produk` | TEXT | Path gambar produk |
| `nama_produk` | TEXT | Nama produk |
| `variant_warna` | TEXT | Varian warna |
| `variant_ukuran` | TEXT | Varian ukuran |
| `harga` | INTEGER | Harga satuan |
| `qty` | INTEGER | Jumlah |
| `selected` | INTEGER | Status seleksi checkbox (0 atau 1) |

---

## 📦 Dependensi

| Package | Kegunaan |
|---|---|
| `get` | Manajemen state & navigasi (GetX) |
| `http` / `dio` | HTTP request ke REST API |
| `shared_preferences` | Penyimpanan token persisten |
| `sqflite` + `path` | Database SQLite lokal untuk keranjang |
| `google_fonts` | Tipografi kustom (Poppins) |
| `google_nav_bar` | Bottom navigation bar |
| `carousel_slider` | Carousel gambar produk |
| `smooth_page_indicator` | Indikator dot halaman onboarding |
| `lottie` | Dukungan animasi Lottie |
| `image_picker` | Pemilihan foto profil/produk |
| `permission_handler` | Request izin runtime |
| `geolocator` | Akses lokasi GPS |
| `geocoding` | Konversi koordinat ke alamat |
| `url_launcher` | Buka URL/maps eksternal |
| `intl` | Format tanggal/mata uang |
| `dropdown_button2` | Widget dropdown yang ditingkatkan |
| `swipeable_button_view` | Tombol geser-untuk-konfirmasi |
| `animated_splash_screen` | Animasi splash screen |
| `page_transition` | Animasi transisi halaman |
| `flutter_spinkit` | Indikator loading |
| `material_design_icons_flutter` | Ikon Material yang diperluas |
| `logger` | Logging debug |

---

## 🚀 Cara Memulai

### Prasyarat

- Flutter SDK `>=3.2.6 <4.0.0`
- Dart SDK yang kompatibel dengan versi Flutter di atas
- Android Studio / VS Code dengan ekstensi Flutter
- Instance backend API KampSewa yang sedang berjalan

### Instalasi

1. **Clone repositori**
   ```bash
   git clone https://github.com/agungkurniawanid/marketplace-kampsewa-app.git
   cd marketplace-kampsewa-app
   ```

2. **Install dependensi**
   ```bash
   flutter pub get
   ```

3. **Konfigurasi base URL API**

   Buka `lib/constants/api_endpoint.dart` dan perbarui:
   ```dart
   class ApiEndpoints {
     static const String baseUrl = "http://IP_SERVER_API_ANDA:PORT";
   }
   ```

4. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

### Build untuk Produksi

```bash
# APK Android
flutter build apk --release

# App Bundle Android (untuk Play Store)
flutter build appbundle --release

# iOS (membutuhkan macOS)
flutter build ios --release
```

---

## 👥 Tim Pengembang

Dikembangkan oleh **TEAM PRODUKTIF4**

---

## 📄 Lisensi

Proyek ini bersifat privat dan tidak diterbitkan ke pub.dev.
