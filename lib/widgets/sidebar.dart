import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: const Color(0xFF2D4599),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildSidebarItem(Icons.grid_view, isSelected: true),
          _buildSidebarItem(Icons.shopping_bag_outlined),
          _buildSidebarItem(Icons.history),
          _buildSidebarItem(Icons.settings),
          const Spacer(),
          _buildSidebarItem(Icons.logout),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
