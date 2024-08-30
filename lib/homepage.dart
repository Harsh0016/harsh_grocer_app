import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'services/grocery_service.dart';
import 'CategoriesPage.dart';
import 'NewArrivalsPage.dart';
import 'wishlistpage.dart';
import 'CartPage.dart';
import 'FruitsPage.dart';
import 'VegetablesPage.dart';
import 'DairyProductsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _futureProducts;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeProducts();
  }

  void _initializeProducts() {
    final groceryService = Provider.of<GroceryService>(context, listen: false);
    _futureProducts = groceryService.fetchGroceryProducts(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => _showCartDialog(context, cartProvider),
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => _showWishlistDialog(context, wishlistProvider),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          } else {
            final products = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  _buildCategoriesSection(context),
                  _buildNewArrivalsSection(context, products, cartProvider, wishlistProvider),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
            _initializeProducts(); // Refresh products based on search query
          });
        },
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesPage()),
                  );
                },
                child: Text('See More'),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                final category = _getCategory(index);
                return _buildCategoryCard(context, category);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getCategory(int index) {
    switch (index) {
      case 0: return 'Fruits';
      case 1: return 'Vegetables';
      case 2: return 'Dairy Products';
      default: return 'Unknown';
    }
  }

  Widget _buildCategoryCard(BuildContext context, String category) {
    final image = _getCategoryImage(category);
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        elevation: 3,
        child: InkWell(
          onTap: () => _navigateToCategoryPage(context, category),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5),
              Text(
                category,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryImage(String category) {
    switch (category) {
      case 'Fruits': return 'assets/images/fruits.jpg';
      case 'Vegetables': return 'assets/images/vegetables.jpg';
      case 'Dairy Products': return 'assets/images/dairy_products.jpg';
      default: return 'assets/images/default.jpg';
    }
  }

  void _navigateToCategoryPage(BuildContext context, String category) {
    Widget page;
    switch (category) {
      case 'Fruits': page = FruitsPage(); break;
      case 'Vegetables': page = VegetablesPage(); break;
      case 'Dairy Products': page = DairyProductsPage(); break;
      default: page = Scaffold(); // Fallback page
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Widget _buildNewArrivalsSection(BuildContext context,
      List<Map<String, dynamic>> products, CartProvider cartProvider,
      WishlistProvider wishlistProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Arrivals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewArrivalsPage()),
                  );
                },
                child: Text('See More'),
              ),
            ],
          ),
          Container(
            height: 500,
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.45,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(context, product, cartProvider, wishlistProvider);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> product,
      CartProvider cartProvider, WishlistProvider wishlistProvider) {
    final itemName = product['name'] ?? 'Unknown';
    final price = (product['price'] is double) ? product['price'] : (product['price'] as int).toDouble();
    final image = product['image'] ?? 'assets/images/default.jpg';
    final description = product['description'] ?? 'No description';
    final cartQuantity = cartProvider.getQuantity(product['id'].toString());
    final isInWishlist = wishlistProvider.isInWishlist(product['id'].toString());

    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 12),
            ),
          ),
          Row(
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
                icon: Icon(
                  Icons.favorite,
                  color: isInWishlist ? Colors.red : Colors.grey,
                ),
                onPressed: () => _handleWishlistClick(context, wishlistProvider, product),
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
  }

  void _handleWishlistClick(BuildContext context, WishlistProvider wishlistProvider, Map<String, dynamic> product) {
    setState(() {
      wishlistProvider.addToWishlist(product);
    });

    // Show feedback before navigating
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to Wishlist'),
        duration: Duration(seconds: 2),
      ),
    );

    // Delay navigation to Wishlist page
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WishlistPage()),
      );
    });
  }

  void _showCartDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cart'),
          content: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              final cartItems = cartProvider.cartItems;
              if (cartItems.isEmpty) {
                return Text('Your cart is empty.');
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: cartItems.entries.map((entry) {
                  final item = entry.value as Map<String, dynamic>;
                  return ListTile(
                    title: Text(item['name'] ?? 'Unknown'),
                    subtitle: Text('\$${item['price']} x ${item['quantity']}'),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Text('Go to Cart'),
            ),
          ],
        );
      },
    );
  }

  void _showWishlistDialog(BuildContext context, WishlistProvider wishlistProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Wishlist'),
          content: Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, child) {
              final wishlistItems = wishlistProvider.wishlistItems;
              if (wishlistItems.isEmpty) {
                return Text('Your wishlist is empty.');
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: wishlistItems.map((item) {
                  return ListTile(
                    title: Text(item['name'] ?? 'Unknown'),
                    subtitle: Text('\$${item['price']}'),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
