import 'package:flutter/material.dart';
import '../entities/product.dart';
import '../pages/ProductListPage.dart';
import '../pages/ProductDetailPage.dart';
import '../pages/CartPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
     if (Product.listProducts.isNotEmpty) {
      _selectedProduct = Product.listProducts[0];
    }
  }

   String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Products';
      case 1:
        return 'Product Detail';
      case 2:
        return 'Cart';
      default:
        return 'Products';
    }
  }

  @override
  Widget build(BuildContext context) {
     final List<Widget> _screens = [
      ProductListPage(
        onProductSelected: (product) {
          setState(() {
            _selectedProduct = product;
            _currentIndex = 1;
          });
        },
      ),
      ProductDetailPage(product: _selectedProduct),
      const CartPage(),
    ];

    return Scaffold(
       appBar: AppBar(
        title: Text(
          _getAppBarTitle(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,

         leading: _currentIndex != 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _currentIndex = 0;
            });
          },
        )
            : null,
      ),

      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Product Detail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}