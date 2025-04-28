import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/food_item.dart';
import '../providers/product_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünleri Yönet'),
        backgroundColor: const Color(0xFF2D4599),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 4,
          ),
          itemCount: products.length + 1,
          itemBuilder: (ctx, i) {
            if (i == 0) {
              // Yeni ürün ekle kartı
              return GestureDetector(
                onTap: () => _showProductDialog(context),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, size: 40, color: Colors.blue),
                      SizedBox(height: 8),
                      Text('Yeni Ürün Ekle',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }

            final prod = products[i - 1];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: prod.imageUrl.isNotEmpty
                        ? prod.imageUrl.startsWith('assets/')
                            ? Image.asset(prod.imageUrl, fit: BoxFit.cover)
                            : Image.file(File(prod.imageUrl),
                                fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(prod.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(prod.category,
                        style: const TextStyle(color: Colors.grey)),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () =>
                              _showProductDialog(context, existing: prod),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => Provider.of<ProductProvider>(
                                  context,
                                  listen: false)
                              .deleteProduct(prod.id),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showProductDialog(BuildContext ctx, {FoodItem? existing}) {
    final isEditing = existing != null;
    final nameC = TextEditingController(text: existing?.name ?? '');
    final priceC =
        TextEditingController(text: existing?.price.toString() ?? '');
    String category = existing?.category ?? 'Yemek';
    XFile? imageFile =
        existing != null && existing.imageUrl.isNotEmpty ? XFile(existing.imageUrl) : null;

    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text(isEditing ? 'Ürünü Düzenle' : 'Yeni Ürün Ekle'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameC,
                decoration: const InputDecoration(labelText: 'Ürün İsmi'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceC,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Fiyat'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: category,
                items: ['Yemek', 'İçecek', 'Atıştırmalık']
                    .map((cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (v) => setState(() => category = v!),
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final picked =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    setState(() => imageFile = picked);
                  }
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: imageFile == null
                      ? const Icon(Icons.image, size: 50)
                      : Image.file(File(imageFile!.path), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameC.text.trim();
              final price = double.tryParse(priceC.text) ?? 0.0;
              if (name.isEmpty || price <= 0) return;

              final newItem = FoodItem(
                id: existing?.id ?? DateTime.now().toIso8601String(),
                name: name,
                category: category,
                price: price,
                imageUrl: imageFile?.path ?? '',
                subCategory: category,
              );
              final prov =
                  Provider.of<ProductProvider>(ctx, listen: false);
              if (isEditing) {
                prov.updateProduct(newItem);
              } else {
                prov.addProduct(newItem);
              }
              Navigator.of(ctx).pop();
            },
            child: Text(isEditing ? 'Güncelle' : 'Ekle'),
          ),
        ],
      ),
    );
  }
}
