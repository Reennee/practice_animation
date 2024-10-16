import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Make sure to add 'get' to pubspec.yaml
import 'theme.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Store',
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: CatalogPage(
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class CatalogPage extends StatelessWidget {
  final VoidCallback onThemeToggle;

  CatalogPage({required this.onThemeToggle});

final List<Product> products = [
  Product(
    name: 'Apple iPhone 13',
    imageUrl: 'https://cdn.pixabay.com/photo/2021/09/24/14/36/iphone-13-6657163_1280.jpg',
    price: 799.00,
  ),
  Product(
    name: 'Samsung Galaxy S21',
    imageUrl: 'https://cdn.pixabay.com/photo/2021/06/14/19/50/smartphone-6330160_1280.jpg',
    price: 699.99,
  ),
  Product(
    name: 'Sony WH-1000XM4',
    imageUrl: 'https://m.media-amazon.com/images/I/51SKmu3ukmL._AC_SX425_.jpg',
    price: 349.99,
  ),
  Product(
    name: 'Apple MacBook Air M2',
    imageUrl: 'https://cdn.pixabay.com/photo/2016/11/29/09/08/apple-1868496_1280.jpg',
    price: 1249.00,
  ),
  Product(
    name: 'Nintendo Switch',
    imageUrl: 'https://cdn.pixabay.com/photo/2017/02/10/22/24/zelda-2056310_1280.jpg',
    price: 299.99,
  ),
  Product(
    name: 'Fitbit Charge 5',
    imageUrl: 'https://m.media-amazon.com/images/I/61XDeaOrrKL._AC_SX425_.jpg',
    price: 149.95,
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: product.name,
          middleText: "Price: \$${product.price}",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
          image: DecorationImage(
            image: NetworkImage(product.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black54,
            padding: EdgeInsets.all(8),
            child: Text(
              product.name,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
