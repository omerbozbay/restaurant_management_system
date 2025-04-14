import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../providers/cart_provider.dart';

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodCard({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food image
          Expanded(
            child: Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    child: Center(
                      child: Icon(
                        _getIconForFood(foodItem.name),
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                // Add to cart button
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D4599),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        cartProvider.addItem(foodItem);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${foodItem.name} Sepete Eklendi'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Food details
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  foodItem.subCategory,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${foodItem.price.toStringAsFixed(0)} TL',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForFood(String foodName) {
    if (foodName.toLowerCase().contains('pilav')) {
      return Icons.rice_bowl;
    } else if (foodName.toLowerCase().contains('makarna')) {
      return Icons.ramen_dining;
    } else if (foodName.toLowerCase().contains('corba')) {
      return Icons.soup_kitchen;
    } else {
      return Icons.fastfood;
    }
  }
}
