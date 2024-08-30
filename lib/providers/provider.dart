import 'package:flutter/material.dart';
import '../services/grocery_service.dart';

class GroceryProvider with ChangeNotifier {
  final GroceryService _groceryService = GroceryService();
  List<dynamic> _products = [];

  List<dynamic> get products => _products;

  Future<void> fetchProducts(String query) async {
    _products = await _groceryService.fetchGroceryProducts(query);
    notifyListeners();
  }
}
