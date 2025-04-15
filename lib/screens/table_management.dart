import 'package:flutter/material.dart';

class TableManagementScreen extends StatelessWidget {
  const TableManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Örnek masa verileri
    final tables = [
      {'name': 'Table 1', 'status': 'available'},
      {'name': 'Table 2', 'status': 'available'},
      {'name': 'Table 3', 'status': 'occupied', 'time': '3 November, 09:45'},
      {'name': 'Table 4', 'status': 'occupied', 'time': '3 November, 08:40'},
      {'name': 'Table 5', 'status': 'available'},
      {'name': 'Table 6', 'status': 'occupied', 'time': '3 November, 08:51'},
      {'name': 'Table 7', 'status': 'occupied', 'time': '3 November, 08:55'},
      {'name': 'Table 8', 'status': 'available'},
      {'name': 'Table 9', 'status': 'available'},
      {'name': 'Table 10', 'status': 'available'},
      {'name': 'Table 11', 'status': 'available'},
      {'name': 'Table 12', 'status': 'available'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Management'),
        backgroundColor: const Color(0xFF2D4599),
        actions: [
          TextButton(
            onPressed: () {
              // Yeni masa oluşturma işlemi
            },
            child: const Text(
              'Generate Table',
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
          itemCount: tables.length,
          itemBuilder: (context, index) {
            final table = tables[index];
            return _buildTableCard(table);
          },
        ),
      ),
    );
  }

  Widget _buildTableCard(Map<String, dynamic> table) {
    final isAvailable = table['status'] == 'available';
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
              table['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isAvailable
                  ? 'available'
                  : 'occupied - ${table['time'] ?? ''}',
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
              child: Text(isAvailable ? 'Open' : 'Close'),
            ),
          ],
        ),
      ),
    );
  }
}