import 'package:flutter/material.dart';

class TableManagementScreen extends StatelessWidget {
  const TableManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek masa verileri
    final Tables = [
      {'name': 'Masa 1', 'status': 'müsait'},
      {'name': 'Masa 2', 'status': 'müsait'},
      {'name': 'Masa 3', 'status': 'dolu', 'time': '3 Kasım, 09:45'},
      {'name': 'Masa 4', 'status': 'dolu', 'time': '3 Kasım, 08:40'},
      {'name': 'Masa 5', 'status': 'müsait'},
      {'name': 'Masa 6', 'status': 'dolu', 'time': '3 Kasım, 08:51'},
      {'name': 'Masa 7', 'status': 'dolu', 'time': '3 Kasım, 08:55'},
      {'name': 'Masa 8', 'status': 'müsait'},
      {'name': 'Masa 9', 'status': 'müsait'},
      {'name': 'Masa 10', 'status': 'müsait'},
      {'name': 'Masa 11', 'status': 'müsait'},
      {'name': 'Masa 12', 'status': 'müsait'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Masa Yonetimi'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2D4599),
        actions: [
          TextButton(
            onPressed: () {
              // Yeni masa oluşturma işlemi
            },
            child: const Text(
              'Masayı Yonet',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Her satırda 4 masa
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: Tables.length,
          itemBuilder: (context, index) {
            final Table = Tables[index];
            return _buildTableCard(Table);
          },
        ),
      ),
    );
  }

  Widget _buildTableCard(Map<String, dynamic> Table) {
    final isAvailable = Table['status'] == 'müsait';
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Table['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isAvailable
                  ? 'müsait'
                  : 'dolu - ${Table['time'] ?? ''}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isAvailable ? Colors.green : Colors.red,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Masa durumu değiştirme işlemi
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isAvailable ? Colors.blue : Colors.red,
              ),
              child: Text(isAvailable ? 'Açık' : 'Kapalı'),
            ),
          ],
        ),
      ),
    );
  }
}