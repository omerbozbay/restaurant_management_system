import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';

enum OrderType { dineIn, toGo }

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  OrderType _orderType = OrderType.dineIn;
  int _orderNumber = 1;

  List<CartItem> get items => [..._items];
  OrderType get orderType => _orderType;
  int get orderNumber => _orderNumber;

  void setOrderType(OrderType type) {
    _orderType = type;
    notifyListeners();
  }

  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }



  double get tax {
    return totalAmount * 0.10; // 10% vergi (KDV)
  }

  double get finalTotal {
    return totalAmount + tax;
  }

  void addItem(FoodItem foodItem) {
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItem.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(
        CartItem(
          foodItem: foodItem,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String foodItemId) {
    _items.removeWhere((item) => item.foodItem.id == foodItemId);
    notifyListeners();
  }

  void decreaseQuantity(String foodItemId) {
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItemId,
    );

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity -= 1;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  void increaseQuantity(String foodItemId) {
    final existingIndex = _items.indexWhere(
      (item) => item.foodItem.id == foodItemId,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _orderNumber++;
    notifyListeners();
  }
}
