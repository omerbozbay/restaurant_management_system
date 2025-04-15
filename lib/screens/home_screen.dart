import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/sidebar.dart';
import '../widgets/category_tabs.dart';
import '../widgets/food_card.dart';
import '../widgets/cart_widget.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Hepsi';

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 1000;

    List<dynamic> filteredItems = _selectedCategory == 'Hepsi'
        ? FOOD_ITEMS
        : FOOD_ITEMS.where((item) => item.category == _selectedCategory).toList();

    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          const Sidebar(),
          
          // Main content
          Expanded(
            flex: 7,
            child: Column(
              children: [
                // App bar
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'KARDEŞLER KEBAP SALONU',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'yemek, içecek vb. ara',
                                  prefixIcon: const Icon(Icons.search),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Siparişler #${cartProvider.orderNumber}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CategoryTabs(
                        selectedCategory: _selectedCategory,
                        onSelectCategory: _selectCategory,
                      ),
                    ],
                  ),
                ),
                
                // Food items and cart
                Expanded(
                  child: Row(
                    children: [
                      // Food items section
                      Expanded(
                        flex: isWideScreen ? 7 : 6,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.grey[100],
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isWideScreen ? 3 : 2,
                              childAspectRatio: 1.1,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemCount: filteredItems.length,
                            itemBuilder: (ctx, i) => FoodCard(
                              foodItem: filteredItems[i],
                            ),
                          ),
                        ),
                      ),
                      
                      // Cart section
                      if (isWideScreen)
                        const Expanded(
                          flex: 3,
                          child: CartWidget(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Cart for smaller screens
          if (!isWideScreen)
            const Expanded(
              flex: 3,
              child: CartWidget(),
            ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return monthNames[month - 1];
  }
}
