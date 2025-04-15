import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../screens/home_screen.dart';
import '../screens/settings.dart';
import '../screens/history.dart';
import '../screens/table_management.dart'; // Table Management ekranını ekliyoruz

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: const Color(0xFF2D4599),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildSidebarItem(
            context,
            Icons.grid_view,
            () => _navigateTo(context, const HomeScreen()),
          ),
          _buildSidebarItem(
            context,
            Icons.table_bar, // Table Management ikonu
            () => _navigateTo(context, const TableManagementScreen()),
          ),
          _buildSidebarItem(
            context,
            Icons.history,
            () => _navigateTo(context, const HistoryScreen()),
          ),
          _buildSidebarItem(
            context,
            Icons.settings,
            () => _navigateTo(context, SettingsScreen()),
          ),
          const Spacer(),
          _buildSidebarItem(
            context,
            Icons.logout,
            () {
              // Logout işlemi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out')),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(BuildContext context, IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}