import 'package:flutter/material.dart';

class VegetablesPage extends StatelessWidget {
  final List<Map<String, String>> vegetables = [
    {'name': 'Cabbage', 'image': 'assets/images/cabbage.png'},
    {'name': 'Cabbage (Alternative)', 'image': 'assets/images/cabbage.jpg'},
    // Add more vegetables as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetables'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: vegetables.length,
        itemBuilder: (context, index) {
          final vegetable = vegetables[index];
          return GridTile(
            child: Image.asset(vegetable['image']!),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(vegetable['name']!),
            ),
          );
        },
      ),
    );
  }
}
