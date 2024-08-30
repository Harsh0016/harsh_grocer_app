import 'package:flutter/material.dart';

class DairyProductsPage extends StatelessWidget {
  final List<Map<String, String>> dairyProducts = [
    {'name': 'Milk', 'image': 'assets/images/milk.png'},
    {'name': 'Cheese', 'image': 'assets/images/dairy_products.jpg'},
    // Add more dairy products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dairy Products'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: dairyProducts.length,
        itemBuilder: (context, index) {
          final dairyProduct = dairyProducts[index];
          return GridTile(
            child: Image.asset(dairyProduct['image']!),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(dairyProduct['name']!),
            ),
          );
        },
      ),
    );
  }
}
