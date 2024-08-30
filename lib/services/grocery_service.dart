import 'package:flutter/material.dart';

class GroceryService with ChangeNotifier {
  // Example method for fetching grocery products
  Future<List<Map<String, dynamic>>> fetchGroceryProducts(String query) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    // Sample data
    List<Map<String, dynamic>> products = [
      {'id': '1', 'name': 'Apple', 'price': 1.0, 'image': 'assets/images/apple.png', 'description': 'Fresh apples'},
      {'id': '2', 'name': 'Bread', 'price': 0.5, 'image': 'assets/images/bread.png', 'description': '1kg bread'},
      {'id': '3', 'name': 'Cabbage', 'price': 1.5, 'image': 'assets/images/cabbage.png', 'description': '1kg cabbage'}
    ];

    // Implement search functionality
    if (query.isNotEmpty) {
      products = products.where((product) {
        return product['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    return products;
  }

  // Example method for fetching new arrivals
  Future<List<Map<String, dynamic>>> fetchNewArrivals() async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));
    return [
      {'id': '1', 'name': 'Apple', 'price': 1.0, 'image': 'assets/images/apple.png', 'description': 'Fresh apples'},
      {'id': '2', 'name': 'Bread', 'price': 0.5, 'image': 'assets/images/bread.png', 'description': '1kg bread'},
      {'id': '3', 'name': 'Cabbage', 'price': 1.5, 'image': 'assets/images/cabbage.png', 'description': '1kg cabbage'},
      {'id': '4', 'name': 'Milk', 'price': 1.2, 'image': 'assets/images/milk.png', 'description': '1 litre milk'},
      {'id': '5', 'name': 'Strawberry', 'price': 2.0, 'image': 'assets/images/strawberry.png', 'description': 'Fresh strawberries'},
    ];
  }

// Add methods to notify listeners if needed
}
