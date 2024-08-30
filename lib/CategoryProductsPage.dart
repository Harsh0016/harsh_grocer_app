import 'package:flutter/material.dart';

class CategoryProductsPage extends StatelessWidget {
  final String category;

  CategoryProductsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Products'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: 8, // Adjust item count as needed
        itemBuilder: (BuildContext context, int index) {
          // Determine image and product details based on category
          final imagePath = category == 'Fruits'
              ? index % 2 == 0 ? 'assets/images/apple.jpg' : 'assets/images/banana.jpg'
              : category == 'Vegetables'
              ? index % 2 == 0 ? 'assets/images/cabbage.jpg' : 'assets/images/carrot.jpg'
              : 'assets/images/dairy_product.jpg';

          final productName = category == 'Fruits'
              ? index % 2 == 0 ? 'Apple' : 'Banana'
              : category == 'Vegetables'
              ? index % 2 == 0 ? 'Cabbage' : 'Carrot'
              : 'Dairy Product';

          final productPrice = index % 2 == 0 ? '110' : '200';

          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1, // Ensure square images
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover, // Reduce white space
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    productName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('৳$productPrice'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Add to Cart functionality
                        },
                        child: Text('Add to Cart'),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Increment functionality
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
