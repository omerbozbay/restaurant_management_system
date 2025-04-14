# 🧾 restaurant_management_system

Bu proje, Flutter ile geliştirilen modern bir **Restoran Yönetim Sistemi** uygulamasıdır. Kullanıcılar yemekleri görüntüleyebilir, sepete ürün ekleyebilir ve ödeme seçenekleriyle sipariş oluşturabilir.

---

## 🚀 Özellikler

- 🍽️ Kategorilere göre yemek listeleme (Yemek, İçecek, Atıştırmalık)
- 🖼️ Görsel destekli ürün kartları (`assets/` klasöründen)
- 🛒 Sepete ürün ekleme / çıkarma / adet değiştirme
- 💳 Ödeme tipi seçimi: Kredi Kartı, Nakit, Veresiye
- 📦 Sipariş türü seçimi: Yerinde Yemek (Dine In), Paket Servis (To Go)
- 🧾 Otomatik KDV hesaplama (%10)
- 🧹 Sipariş tamamlandığında sepeti temizleme
- 🌙 Modern, sade ve responsive kullanıcı arayüzü

---

## 🧱 Kullanılan Teknolojiler

- **Flutter** – UI geliştirme
- **Dart** – Programlama dili
- **Provider** – Durum yönetimi
- **Material Design** – UI bileşenleri
- **Asset Management** – Görsel kullanımı

---

## 📁 Klasör Yapısı

```bash
lib/
├── main.dart
├── models/
│   ├── food_item.dart
│   └── cart_item.dart
├── providers/
│   └── cart_provider.dart
├── screens/
│   └── home_screen.dart
├── widgets/
│   ├── food_card.dart
│   ├── cart_widget.dart
│   ├── sidebar.dart
│   └── category_tabs.dart
├── utils/
│   └── constants.dart
