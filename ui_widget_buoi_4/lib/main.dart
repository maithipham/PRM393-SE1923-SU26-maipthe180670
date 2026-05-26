import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      //giao diện đầu tiên hiển thị lên khi chạy phần mềm nằm trong home
      home: Scaffold(
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
          actions: [IconButton(onPressed: onPress(), icon: Icon(Icons.more_vert))],
        ),
        body: 
        // SafeArea(child: Text("Hello world",
        //   style: TextStyle(color: Colors.amber, fontSize: 19),
        //   textAlign: TextAlign.center,) ),
        // Bọc image trong container
        Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Image.asset("assets/images/222203.png",
            fit: BoxFit.fill,)),

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.green,
            backgroundColor: Colors.black12,
            items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home, color: Colors.green,),),
              BottomNavigationBarItem(
                label: "Favorites",
                icon: Icon(Icons.home, color: Colors.green,),),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.home, color: Colors.green,),),
          ]),
          
      ),

    );


  }
}