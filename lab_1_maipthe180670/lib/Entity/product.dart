import 'dart:convert';
import 'dart:io';

class Product{
  /*
  Lab 1: Xây dựng lớp Product  (id, name, image, price )
  có các thuộc tính và 1 danh sách tĩnh gồm List<Product>
  và xây dựng các phương thức để
  hiển thị, sắp xếp, thêm, xóa, sửa, tìm kiếm, ....

  Lab 1 UPDATE: Xây dựng lớp Product  (id, name, image, price )
  có các thuộc tính và 1 danh sách tĩnh gồm List<Product>
  (gán cho một số giá trị mặc đinh) và xây dựng các phương thức sau:
- Phương thức khởi tạo, phương thức khởi tạo const; phương thức factory để map một Json về Product
- Xây dựng lớp ProductDAO Phương thức add(product), Edit(product), Search khác nhau,
  increasePrice (để tăng giá của mỗi sản phẩm lên 10% dùng declarative- map), Find,....
   */
  final String id;
  final String name;
  final String? image;
  final double price;

  //phương thức khởi tạo
  Product({
    required this.id,
    required this.name,
    this.image,
    required this.price
  });

  //phương thức khởi tạo hảng số constant
  const Product.constant({
    required this.id,
    required this.name,
    this.image,
    required this.price
});

  //phương thức factory để map 1 json thành Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      id: json['id'],
      image: json['image'],
      price: json['price'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id, 'image': image, 'price': price};
  }

  //hàm copyWith hỗ trợ sửa đổi dữ liệu khi có biến final
  Product copyWith({String? name, String? id, String? image, double? price}) {
    return Product(
      name: name ?? this.name,
      id: id ?? this.id,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return  '[ID: ${id}, Tên: ${name}, Ảnh: ${image}, Giá: ${price}]';
    ;
  }

  static List<Product>  productList = [
    Product(id: "P01", name: "Sữa chua TH True", image: "suachua.png", price: 8500),
    Product(id: "P02", name: "Sữa tươi tiệt trùng", image: "suatuoi.png", price: 32000),
    Product(id: "P03", name: "Bánh mì gối", image: "banhmi.png", price: 25000),
    Product(id: "P04", name: "Kem tràng tiền", image: "kem.png", price: 12000),
    Product(id: "P05", name: "Nước khoáng Aquafina", image: "nuoc.png", price: 5000),
  ];

}