import 'package:flutter/material.dart';
import 'package:lab5/Pages/AboutPage.dart';
import 'package:lab5/Product_Widget.dart';

import 'Pages/HomePage.dart';
import 'Pages/ProductDetailPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  //giao diện ko thay đổi nên để là const
  const MyApp({super.key});
  // có 2 phong cách Material của google
  // có phong cách của ios cupertino

  @override
  // StatelessWidget -> gọi đến phương thức khơi tạo sau đó-> goi đến phương thức build
  // cần gọi hàm build
  Widget build(BuildContext context){
    onPress(){};
    return MaterialApp(
      title: "Lab 5",
      //định nghĩa Router để điều hướng trang
      initialRoute: '/',
      routes: {
        '/': (context)=> HomePage(),
        '/detail': (context)=> ProductDetailPage(),
        '/about': (context)=> AboutPage(),
      },
      debugShowCheckedModeBanner: false,
      //giao diện đầu tiên hiển thị lên khi chạy phần mềm nằm trong home
      //  home: const MainDashBoard(),
    );
  }
}




class MainDashBoard extends StatelessWidget {
  const MainDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: RichText(
            text: TextSpan(
              text: "Home page",
              style: TextStyle(
                  color: Colors.blueAccent, fontSize: 19),
              children: [TextSpan(
                text: "Flutter UI",
                style: TextStyle(color: Colors.blueAccent, fontSize: 19,),
              ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.amber,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: (){
                //Chuyển huwosnh sang trang about
                Navigator.pushNamed(context, '/about');
              },
              icon: Icon(Icons.more_vert))],
      ),
      body:
      // SafeArea(child: Text("Hello world",
      //   style: TextStyle(color: Colors.amber, fontSize: 19),
      //   textAlign: TextAlign.center,) ),
      // Bọc image trong container
      Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child:
        //Image.asset("assets/images/222203.png",fit: BoxFit.fill,
        //hiển thị danh sách sản phẩm
        const ProductListWidget(),
      ),

      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          backgroundColor: Colors.grey,
          onTap: (index){
            Navigator.pushNamed(context, '/about');
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home, color: Colors.green,),),
            BottomNavigationBarItem(
              label: "Detail product",
              icon: Icon(Icons.details, color: Colors.green,),),
            BottomNavigationBarItem(
              label: "About",
              icon: Icon(Icons.account_balance_outlined, color: Colors.green,),),
          ]),

    );
  }
}
