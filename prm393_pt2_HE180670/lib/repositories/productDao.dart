import '../entities/product.dart';

class ProductDAO {
  List<Product> l;

  ProductDAO(this.l);

  List<Product> getAllProduct() {
    return l;
  }

  List<Product> findProductByName(String keyword) {
    return l
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }
}