import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek sipariş geçmişi verileri
    final orders = [
      {
        'siparisNo': '#001',
        'tarih': '3 Kasım, 09:45',
        'toplam': 150.0,
        'durum': 'Tamamlandı',
      },
      {
        'siparisNo': '#002',
        'tarih': '3 Kasım, 10:15',
        'toplam': 200.0,
        'durum': 'Tamamlandı',
      },
      {
        'siparisNo': '#003',
        'tarih': '3 Kasım, 11:00',
        'toplam': 300.0,
        'durum': 'İptal Edildi',
      },
      {
        'siparisNo': '#004',
        'tarih': '3 Kasım, 12:30',
        'toplam': 250.0,
        'durum': 'Tamamlandı',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Geçmisi'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2D4599),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _buildOrderCard(order);
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final isCompleted = order['durum'] == 'Tamamlandı';
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order['siparisNo'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'tarih: ${order['tarih']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'toplam: \$${order['toplam'].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'durum: ${order['durum']}',
              style: TextStyle(
                fontSize: 14,
                color: isCompleted ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Sipariş detaylarını görüntüleme işlemi
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2D4599),
              ),
              child: const Text('Detayları Gör'),
            ),
          ],
        ),
      ),
    );
  }
}