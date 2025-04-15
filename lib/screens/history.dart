import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Örnek sipariş geçmişi verileri
    final orders = [
      {
        'orderNumber': '#001',
        'date': '3 November, 09:45',
        'total': 150.0,
        'status': 'Completed',
      },
      {
        'orderNumber': '#002',
        'date': '3 November, 10:15',
        'total': 200.0,
        'status': 'Completed',
      },
      {
        'orderNumber': '#003',
        'date': '3 November, 11:00',
        'total': 300.0,
        'status': 'Cancelled',
      },
      {
        'orderNumber': '#004',
        'date': '3 November, 12:30',
        'total': 250.0,
        'status': 'Completed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
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
    final isCompleted = order['status'] == 'Completed';
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
              order['orderNumber'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${order['date']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: \$${order['total'].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${order['status']}',
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
                backgroundColor: const Color(0xFF2D4599),
              ),
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}