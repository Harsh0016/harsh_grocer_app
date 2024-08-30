import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _wishlistItems = [];

  void addToWishlist(Map<String, dynamic> item) {
    final itemId = item['id'];
    if (itemId == null) {
      print('Error: Item does not have an id.');
      return;
    }
    if (!_wishlistItems.any((existingItem) => existingItem['id'] == itemId)) {
      _wishlistItems.add(item);
      notifyListeners();
    }
  }

  void removeFromWishlist(Map<String, dynamic> item) {
    final itemId = item['id'];
    if (itemId == null) {
      print('Error: Item does not have an id.');
      return;
    }
    _wishlistItems.removeWhere((existingItem) => existingItem['id'] == itemId);
    notifyListeners();
  }

  bool isInWishlist(String itemId) {
    return _wishlistItems.any((item) => item['id'] == itemId);
  }

  List<Map<String, dynamic>> get wishlistItems {
    return List.unmodifiable(_wishlistItems);
  }
}
