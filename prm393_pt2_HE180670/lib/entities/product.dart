class Product {
  final String id;
  final String name;
  final double price;
  final int discountPercen;
  final double starNumber;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discountPercen,
    required this.starNumber,
    required this.imageUrl,
  });

  static List<Product> listProducts = [
    Product(
      id: '1',
      name: 'iPhone 15',
      price: 999,
      discountPercen: 10,
      starNumber: 4.8,
      imageUrl: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-plus_1__1.png',
    ),
    Product(
      id: '2',
      name: 'Samsung S24',
      price: 899,
      discountPercen: 15,
      starNumber: 4.7,
      imageUrl: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-galaxy-s24_18__1.png',
    ),
    Product(
      id: '3',
      name: 'MacBook Air',
      price: 1200,
      discountPercen: 5,
      starNumber: 4.9,
      imageUrl: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/0/1/01_6_4.png',
    ),
  ];
}