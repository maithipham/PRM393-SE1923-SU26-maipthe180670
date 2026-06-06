import 'package:flutter/material.dart';
import 'package:lab5/Product_Widget.dart';

class ProductDetailPage extends StatefulWidget {
const ProductDetailPage({super.key});

@override
State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
//khởi tạo cái gì mà liên quan đến current idex í
  int _selectedIndex = 0;
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      // Có leading tự tường minh đóng màn hình quay lại Router trang trước
      leading: IconButton(
          onPressed: (){
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.menu)),
      // Viết nhiều title bằng toán tử điều kiện
      // title: Center(child: Text("Home page")),
      // Index 0 -> Home (Chứa cả TabBar sản phẩm động)
      title: _selectedIndex == 0
          ? const Text("Home page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          : _selectedIndex == 1
          ? const Text("Detail product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
          : const Text("About page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

      centerTitle: true,
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context,'/detail');
          // Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPage()));
        },
            icon: Icon(Icons.more_vert, color: Colors.white,)),
      ],

      // title: Center(child: Text("About page"),),
    ),
    body: [ProductListWidget(),
      //truyền nội dung của từng page, body của trang About page có text là About thoi
      Center(child: Text("Detail product")),
      Center(child: Text("About"))
    ][_selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,// có thể index cứng như 0 1 2 3
        onTap: (index){
          setState((){
            _selectedIndex = index;});
        },
        /* tìm hiểu tapControl
          curentIndex: _selecttedIndex,
          onTap: (index){
          setState((){
          _selectedIndex = index;});},
           */
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.details), label: "Detail"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined), label: "About")]),
  );
}
}

