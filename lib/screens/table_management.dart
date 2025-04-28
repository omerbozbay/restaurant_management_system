import 'package:flutter/material.dart';

class TableManagementScreen extends StatefulWidget {
  @override
  _TableManagementScreenState createState() => _TableManagementScreenState();
}

class _TableManagementScreenState extends State<TableManagementScreen> {
  List<Map<String, dynamic>> tables = List.generate(
    12,
    (i) => {'name': 'Masa ${i+1}', 'status': 'müsait', 'time': ''},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Masa Yönetimi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemCount: tables.length,
          itemBuilder: (ctx, i) {
            final t = tables[i];
            final available = t['status']=='müsait';
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(t['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    available ? 'Müsait' : 'Dolu\n${t['time']}',
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: available ? Colors.green : Colors.red),
                    child: Text(available ? 'Aç' : 'Kapat'),
                    onPressed: () {
                      setState(() {
                        if (t['status']=='müsait') {
                          t['status']='dolu';
                          t['time'] = '${DateTime.now().hour}:${DateTime.now().minute}';
                        } else {
                          t['status']='müsait';
                          t['time']='';
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
