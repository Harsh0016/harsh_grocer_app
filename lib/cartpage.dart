import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No items in cart'))
          : ListView(
        children: cartItems.entries.map((entry) {
          final itemId = entry.key;
          final itemData = entry.value;
          final item = itemData['item'] ?? {};
          final quantity = itemData['quantity'] ?? 0;

          final itemName = item['name'] ?? 'Unknown';
          final itemPrice = item['price'] != null
              ? item['price'].toStringAsFixed(2)
              : '0.00';
          final itemImageUrl = item['image'] ?? 'assets/images/default.png';

          return ListTile(
            leading: Image.asset(
              itemImageUrl,
              fit: BoxFit.cover,
              width: 50.0,
              height: 50.0,
            ),
            title: Text(itemName),
            subtitle: Text('\$$itemPrice'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => cartProvider.decreaseQuantity(itemId),
                ),
                Text('$quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => cartProvider.addToCart(item),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${cartProvider.getTotalAmount().toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () {
                  // Handle checkout or other action
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
