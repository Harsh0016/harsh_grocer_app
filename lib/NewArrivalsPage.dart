import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CartPage.dart';
import 'services/grocery_service.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';

class NewArrivalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groceryService = Provider.of<GroceryService>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Arrivals'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: groceryService.fetchNewArrivals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No new arrivals found'));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.45,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                final itemName = product['name'] ?? 'Unknown';
                final price = (product['price'] is double)
                    ? product['price']
                    : (product['price'] as int).toDouble();
                final image = product['image'] ?? 'assets/images/default.png'; // Update image path
                final description = product['description'] ?? 'No description';

                final cartQuantity = cartProvider.getQuantity(product['id'].toString());

                return Card(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(itemName),
                      Text('\$${price.toStringAsFixed(2)}'),
                      Text(description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              if (cartQuantity > 0) {
                                cartProvider.decreaseQuantity(product['id'].toString());
                              }
                            },
                          ),
                          Text(cartQuantity.toString()),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              cartProvider.addToCart(product);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              wishlistProvider.addToWishlist(product);
                            },
                          ),
                        ],
                      ),
                      if (cartQuantity > 0)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CartPage()),
                              );
                            },
                            child: Text('Go to Cart'),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
