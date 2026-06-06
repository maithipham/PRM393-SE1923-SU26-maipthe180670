import 'package:lab5/Entity/Product.dart';

class Productdao {
  List<Product> l;
  Productdao(this.l);
  void getAllProduct() {
    l = Product.products;
  }

  void addProduct(Product p) {
    var index = l.indexWhere((element) => element.id == p.id);
    if (index < 0) l.add(p);
  }

  void deleteProduct(String id) {
    l.removeWhere((element) => element.id == id);
  }

  void updateProduct(Product pNew) {
    var index = l.indexWhere((element) => element.id == pNew.id);
    var p = l[index];
    l.remove(p);
    l.add(pNew);
  }
}