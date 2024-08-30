import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wishlist_provider.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: wishlistProvider.wishlistItems.isEmpty
          ? Center(child: Text('Your wishlist is empty.'))
          : ListView.builder(
        itemCount: wishlistProvider.wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistProvider.wishlistItems[index];
          final itemName = item['name'] ?? 'Unknown';
          final image = item['image'] ?? 'assets/images/default.jpg';

          return ListTile(
            leading: Image.asset(
              image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(itemName),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                wishlistProvider.removeFromWishlist(item);
              },
            ),
          );
        },
      ),
    );
  }
}
