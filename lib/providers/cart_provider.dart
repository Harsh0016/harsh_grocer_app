import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Map<String, dynamic>> _cartItems = {}; // Store items by ID

  // Add an item to the cart
  void addToCart(Map<String, dynamic> item) {
    final itemId = item['id'];
    if (_cartItems.containsKey(itemId)) {
      _cartItems[itemId]!['quantity'] += 1;
    } else {
      _cartItems[itemId] = {
        'item': item,
        'quantity': 1,
      };
    }
    notifyListeners();
  }

  // Decrease the quantity of an item in the cart
  void decreaseQuantity(String itemId) {
    if (_cartItems.containsKey(itemId)) {
      if (_cartItems[itemId]!['quantity'] > 1) {
        _cartItems[itemId]!['quantity'] -= 1;
      } else {
        _cartItems.remove(itemId);
      }
      notifyListeners();
    }
  }

  // Get the quantity of a specific item
  int getQuantity(String itemId) {
    return _cartItems.containsKey(itemId) ? _cartItems[itemId]!['quantity'] : 0;
  }

  // Calculate the total amount of items in the cart
  double getTotalAmount() {
    return _cartItems.values.fold(0.0, (total, item) {
      final price = item['item']['price'] ?? 0.0;
      final quantity = item['quantity'];
      return total + (price * quantity);
    });
  }

  // Retrieve all cart items
  Map<String, Map<String, dynamic>> get cartItems {
    return _cartItems;
  }
}
