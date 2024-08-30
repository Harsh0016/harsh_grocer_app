import 'package:flutter/material.dart';

class FruitsPage extends StatelessWidget {
  final List<Map<String, String>> fruits = [
    {'name': 'Apple', 'image': 'assets/images/apple.png'},
    {'name': 'Kiwi', 'image': 'assets/images/kiwi.png'},
    {'name': 'Strawberry', 'image': 'assets/images/strawberry.png'},
    {'name': 'Watermelon', 'image': 'assets/images/watermelon.png'},
    // Add more fruits as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruits'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return GridTile(
            child: Image.asset(fruit['image']!),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(fruit['name']!),
            ),
          );
        },
      ),
    );
  }
}
