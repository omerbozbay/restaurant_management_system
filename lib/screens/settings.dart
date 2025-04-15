import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'name': 'Lahmacun', 'category': 'Yemek'},
  ];

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2D4599),
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: const Color(0xFF2D4599),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSidebarItem(Icons.grid_view, 'Ürünleri Yönet', isSelected: true),
                _buildSidebarItem(Icons.discount, 'İndirimleri Yönet'),
                _buildSidebarItem(Icons.print, 'Yazıcı Yönet'),
                _buildSidebarItem(Icons.calculate, 'Maliyet Hesaplama'),
                _buildSidebarItem(Icons.sync, 'Veri Senkronize'),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ürünleri Yönet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Mağazadaki Ürünleri Yönet',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: products.length + 1, // +1 for "Add New Product" card
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              _showAddProductDialog(context);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Yeni Ürün Ekle',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          final product = products[index - 1];
                          return _buildProductCard(product['name']!, product['category']!);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String productName, String category) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              category,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Görüntüle'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Düzenle'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController stockController = TextEditingController();
    String selectedCategory = 'İçecek';
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ürün Ekle'),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ürün Ismi',
                    hintText: 'Ürün İsmi Girin',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Fiyat',
                    hintText: 'Fiyat Girin',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                const Text('Ürün Fotoğrafı'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    selectedImage = await picker.pickImage(source: ImageSource.gallery);
                    if (selectedImage != null) {
                      print('Seçili resim yolu: ${selectedImage!.path}');
                    } else {
                      print('Seçili resim yok');
                    }
                  },
                child: const Text('Fotoğraf Seç'),
              ),
                const SizedBox(height: 10),
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(
                    labelText: 'Stok',
                    hintText: 'Stok miktarını girin',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: ['İçecek', 'Atıştırmalık']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedCategory = value!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Save product logic
                print('Ürün Kaydedildi: ${nameController.text}');
                Navigator.of(context).pop();
              },
              child: const Text('Ürünü Kaydet'),
            ),
          ],
        );
      },
    );
  }
}