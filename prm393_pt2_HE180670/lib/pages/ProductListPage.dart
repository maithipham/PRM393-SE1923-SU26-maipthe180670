import 'package:flutter/material.dart';
import '../entities/product.dart';
import '../repositories/productDao.dart';

class ProductListPage extends StatefulWidget {
  final Function(Product) onProductSelected;

  const ProductListPage({super.key, required this.onProductSelected});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductDAO _productDAO = ProductDAO(Product.listProducts);
  List<Product> _displayProducts = [];

  @override
  void initState() {
    super.initState();
    _displayProducts = _productDAO.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 4.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFFF2F2F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onChanged: (value) {
              setState(() {
                _displayProducts = _productDAO.findProductByName(value);
              });
            },
          ),
        ),


        Expanded(
          child: OrientationBuilder(
            builder: (context, orientation) {
              int crossAxisCount = orientation == Orientation.portrait ? 1 : 2;

              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: orientation == Orientation.portrait ? 3.0 : 2.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _displayProducts.length,
                itemBuilder: (context, index) {
                  final product = _displayProducts[index];

                  return Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        widget.onProductSelected(product);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '\$${product.price}',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (product.discountPercen > 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade100,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            '-${product.discountPercen}%',
                                            style: const TextStyle(color: Colors.red, fontSize: 11),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 14),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${product.starNumber}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}