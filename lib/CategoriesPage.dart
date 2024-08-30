import 'package:flutter/material.dart';
import 'package:harsh_grocery_app/CategoryProductsPage.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Image.asset(
              'assets/images/fruits.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover, // Ensures image fits well
            ),
            title: Text('Fruits'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductsPage(category: 'Fruits'),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/vegetables.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover, // Ensures image fits well
            ),
            title: Text('Vegetables'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductsPage(category: 'Vegetables'),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/dairy_products.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover, // Ensures image fits well
            ),
            title: Text('Dairy Products'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductsPage(category: 'Dairy Products'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
