import 'package:flutter/material.dart';
import 'package:lab5/Repository/ProductDAO.dart';
import 'Entity/Product.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final List<Product> products = Product.products;

  @override
  Widget build(BuildContext context)
//   {
//     return ReponsiveProduct(products: products);
//   }
// }
  {
    // KẾT HỢP TABBAR CHO BÀI LAB 5: Phân chia danh mục sản phẩm trên đầu trang
    return DefaultTabController(
      // Số lượng Tab
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Tất cả sản phẩm"),
              Tab(text: "Sản phẩm mới"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Tab 1: Hiển thị danh sách Responsive GridView
                ReponsiveProduct(products: products),
                // Tab 2: Hiển thị danh sách trống hoặc lọc dữ liệu
                const Center(child: Text("Danh mục sản phẩm mới trống")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReponsiveProduct extends StatelessWidget {
  List<Product> products;
   ReponsiveProduct({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    //trả về số cột tuy hướng của thiết bị: kết hướng và kích thước   MediaQuery.of(context)orientation==Orientation.landscape ?2:1
    int crossAxisCount = MediaQuery.of(context).size.width<400?1:2;
    return GridView.count(
      crossAxisSpacing: 4, // Khoảng cách ngang giữa các ô Card
      mainAxisSpacing: 2,// Khoảng cách dọc giữa các hàng ô Card
      // crossAxisCount: MediaQuery.of(context).size.width<400?1:2 ,
      crossAxisCount: crossAxisCount,
      // nếu có 2 cột thì tỉ lệ màn hình ngang 0.7 => Card ko thì dài thừa thãi
      childAspectRatio: crossAxisCount == 2 ? 1.2 : 1,
      //children của chúng ta là product widget là map product sang list
      children: products.map((product)=> ProductWidget(product: product)).toList(),
    );
  }
}


// class OneColumnProduct extends StatelessWidget {
//   List products ;
//   OneColumnProduct({super.key, required this.products});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         // return const ProductWidget();
//         return ProductWidget(product: products[index]);
//       },
//     );
//   }
// }


class ProductWidget extends StatefulWidget {
  // const ProductWidget({super.key});
  Product product;
  ProductWidget({super.key, required this.product,});


  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int count = 0;
  var products = Product.products;
  @override
  Widget build(BuildContext context) {
    final currentProduct = widget.product;

    return LayoutBuilder(
        builder: (context, constraints){
          double cardWidth = constraints.maxWidth;

          return Card( // Đưa Card ra ngoài cùng để bọc toàn bộ thông tin sản phẩm cho đẹp
          margin: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias, // Giúp bo góc ảnh theo viền Card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Phần hình ảnh sản phẩm (Khống chế chiều cao cố định 200 thay vì Expanded lỗi)
              Stack(
                children: [
                  Container(
                    //width: MediaQuery.of(context).size.width < 400?
                    width: constraints.maxWidth <400?
                    MediaQuery.of(context).size.width:
                    MediaQuery.of(context).size.width/2,//double.infinity,//đây là con số tràn viền => dùng media.width.if
                    height: 200,
                    color: Colors.grey[200], // Tạo nền xám phòng trường hợp ảnh chưa load được
                    child: Image.asset(
                      'assets/images/${currentProduct.image}.jpg',
                      fit: BoxFit.contain,
                      //'assets/image/dog.png',
                      // fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Hiển thị text thay thế nếu không tìm thấy file ảnh tránh lỗi gạch chéo đỏ
                        return const Center(
                            child: Icon(
                                Icons.image, size: 50, color: Colors.grey));
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      label: const Text("Add to cart"),
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ),
                ],
              ),

              // 2. Phần thông tin: Tên, giá, đánh giá sao, số lượng
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Tên và Giá sản phẩm
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Product: ${currentProduct.name}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 4),
                          Text("Price: ${currentProduct.price.toStringAsFixed(0)} VND",
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    // Hàng 5 ngôi sao đánh giá (Bọc trong Wrap để tự xuống dòng nếu màn hình hẹp)
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                        ],
                      ),
                    ),

                    // Nút tăng số lượng và Text hiển thị
                    Row(
                      children: [
                        IconButton(
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                          icon: const Icon(Icons.add_circle, color: Colors.orange, size: 22,),
                        ),
                        SizedBox(height: 4),
                        Text(
                          count.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 3. Phần văn bản tin tức dưới cùng (Bỏ hẳn Expanded sai cấu trúc)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,  ),
                child: Text(
                  "Tổng Bí thư, Chủ tịch nước nói mục tiêu tăng trưởng 11% đầy thách thức nên Hà Nội không thể tiếp tục bước đi theo mô hình cũ, hay lợi thế sẵn có mà phải dựa trên khoa học và kinh tế số.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
              ),
            ],
          ),
          );
        });
  }
}
