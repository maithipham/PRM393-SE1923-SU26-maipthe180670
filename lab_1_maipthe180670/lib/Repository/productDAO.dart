import 'dart:convert';
import 'dart:io';

import 'package:lab_1_maipthe180670/Entity/product.dart';

class productDAO{
  // - Xây dựng lớp ProductDAO Phương thức add(product), Edit(product), Search khác nhau,
  //   increasePrice (để tăng giá của mỗi sản phẩm lên 10% dùng declarative- map), Find,....
  List<Product> l;
  productDAO(this.l);
  List<Product> getAllProduct(){
    l = Product.productList;
    return l;
  }

  // void addProduct(Product p){
  //   var index = l.indexWhere((element) => element.id.toLowerCase() == p.id.toLowerCase());
  //   if(index < 0){
  //     l.add(p);
  //     print("Thêm sản phẩm ${p.name} vào danh sách thành công!");
  //   } else {
  //     print("Thêm thất bại: Trùng ID sản phẩm.");
  //   }
  // }

  // Phương thức tăng giá 10% đồng loạt bằng Declarative Map
  void increasePrice() {
    Product.productList = Product.productList.map((p) {
      return p.copyWith(price: (p.price * 1.1).roundToDouble());}
    ).toList();
    l = Product.productList;
    print("Đã tăng giá toàn bộ sản phẩm lên 10%!");
    displayProduct();
  }


  //_hàm hiển thị form
  void displayForm(){
    stdout.write('----------------List product----------------\n'
        '1. Hiển thị danh sách sản phẩm\n'
        '2. Sắp xếp danh sách sản phẩm\n'
        '3. Thêm mới sản phẩm vào danh sách\n'
        '4. Sửa thông tin sản phẩm\n'
        '5. Xóa sản phẩm khỏi danh sách\n'
        '6. Tìm kiếm sản phẩm\n'
        '7. Tăng 10% giá sản phẩm\n'
        '8. Thoát chương trình\n'
        '--------------------------------------------\n'
        'Chọn 1 option từ 1-8: ');
  }

  //_hàm hiển thị sản phẩm
  void displayProduct() {
    if (l.isEmpty) {
      print("Danh sách sản phẩm trống!");
      return;
    }
    print('||  ID   ||  Name                       ||  Image         ||  Price   ');
    print('======================================================================');
    for (var x in l) {
      print('||  ${x.id.padRight(4)} ||  ${x.name.padRight(26)} ||  ${(x.image ?? "").padRight(13)} ||  ${x.price}');
    }
    print("\n");
  }

  //_hàm sắp xếp
  void sortProduct({String? autoNameSort, String? autoTypeSort}){
    String nameSort = autoNameSort ?? "";
    String typeSort = autoTypeSort ?? "";
    if (autoNameSort == null || autoTypeSort == null) {
      while (true) {
        stdout.write("Nhập tiêu chí muốn sắp xếp (id / name / price): ");
        nameSort = stdin.readLineSync() ?? "";
        if (!['id', 'name', 'price'].contains(nameSort)) {
          print("Yêu cầu phải nhập một trong những ký tự: id/ name/ price.");
          continue;
        }
        break;
      }

      while (true) {
        stdout.write("Nhập kiểu sắp xếp tăng/ giảm(T/ G): ");
        typeSort = stdin.readLineSync() ?? "";
        if (!['t', 'g'].contains(typeSort)) {
          continue;
        }
        break;
      }
    }
    for(int i =0; i<l.length-1; i++){
      for(int j=i+1; j< l.length; j++){

        var valI;
        var valJ;
        switch(nameSort.toLowerCase()){
          case "id":
            valI = l[i].id;
            valJ = l[j].id;
            break;
          case "name":
            valI = l[i].name;
            valJ = l[j].name;
            break;
          case "price":
            valI = l[i].price;
            valJ = l[j].price;
            break;
          default:
            valI = l[i].id;
            valJ = l[j].id;
        }

        bool swap = false;
        if(typeSort.toLowerCase() == "t"){
          if(valI.compareTo(valJ)>0){
            swap =true;
          }
        }else if(typeSort.toLowerCase() == "g"){
          if(valI.compareTo(valJ)<0){
            swap =true;
          }
        }

        if(swap){
          var temp = l[i];
          l[i] = l[j];
          l[j] = temp;
        }
      }
    }
    if (autoNameSort == null || autoTypeSort == null) {
      print(
          ">> Danh sách sản phẩm sau khi xếp ${typeSort.toLowerCase().trim() == 't'
              ? 'tăng dần'
              : 'giảm dần'} theo "
              "${nameSort}:");
      displayProduct();
    }
  }

  //_hàm thêm sản phẩm mới
  String addProduct() {
    print("--- THÊM SẢN PHẨM MỚI ---");

    String id;
    var index;
    while (true) {
      stdout.write("Nhập mã sản phẩm (ID): ");
      id = stdin.readLineSync() ?? "";
      index = l.indexWhere((element) => element.id.toLowerCase() == id.toLowerCase());
      if (id.trim().isEmpty) {
        print("Mã sản phẩm không được để trống!");
      } else if (index>=0) {
        print("Mã sản phẩm này đã tồn tại! Vui lòng dùng mã khác.");
      } else {
        break;
      }
    }
    String name = InputName("");
    String image = InputImage("");
    double price = InputPrice(0.0);

    Product newProduct = Product(id: id, name:  name, image:  image, price:  price);
    if(index < 0){
      l.add(newProduct);
      print("Thêm sản phẩm ${newProduct.name} vào danh sách thành công!");
    } else {
      print("Thêm thất bại: Trùng ID sản phẩm.");
    }
    print("");
    return "Thành công";
  }

  //_hàm sửa thông tin sản phẩm
  String updateProduct() {
    print("--- SỬA THÔNG TIN SẢN PHẨM ---");
    String id;
    int index;
    while(true){
      stdout.write("Nhập mã ID sản phẩm cần sửa: ");
      id = stdin.readLineSync() ?? "";
      index = l.indexWhere((x) => x.id.toLowerCase() == id.toLowerCase());
      if(index>=0){
        break;
      }else{
        print("Không tồn tại sản phẩm có mã $id!");
      }
    }
    Product sp = l[index];
    print("Thông tin hiện tại: ${sp.toString()}");
    String currentName = InputName(sp.name);
    String currentImage = InputImage(sp.image ?? "");
    double currentPrice = InputPrice(sp.price);
    Product newProduct = Product(id: id, name:  currentName, image:  currentImage, price:  currentPrice);

    //cách 1
    l.remove(sp);
    l.add(Product(id: sp.id, name:  currentName, image:  currentImage, price:  currentPrice));
    //cách 2
    // l[index] = sp.copyWith(
    //   name: currentName,
    //   image: currentImage,
    //   price: currentPrice,
    // );
    print(">> Hoàn tất quá trình cập nhật thông tin sản phẩm ${sp.id}!");
    print("\n");
    return "Thành công";
  }

  //_hàm xóa sản phẩm khỏi danh sách
  String deleteProduct() {
    print("--- XÓA SẢN PHẨM KHỎI DANH SÁCH ---");
    print("Có thể xóa một hoặc nhiều sản phẩm.");
    List<String> targetIds = [];
    List<Product> itemToDelete = [];
    while(true){
      stdout.write("Nhập mã các sản phẩm cần xóa (cách nhau bởi dấu cách, ví dụ: P01 P03): ");
      String inputId = stdin.readLineSync() ?? "";

      // tách chuỗi nhập vào thành list danh sách các Id riêng biệt
      targetIds = inputId.split(" ").where((id) => id.toLowerCase().trim().isNotEmpty).toList();

      // tìm và hiển thị thông tin những sản phẩm sắp bị xóa để kiểm tra thông tin
      itemToDelete = l.where((p) => targetIds.contains(p.id.toLowerCase())).toList();

      if(targetIds.isEmpty){
        print("Không có mã sản phẩm nào được nhập!");
        continue;
      }else if (itemToDelete.isEmpty ) {
        print("Không tìm thấy sản phẩm nào khớp với các mã bạn vừa nhập.");
        continue;
      }
      break;
    }

    print("Danh sách sản phẩm sẽ bị xóa:");
    List<String>? id =[];
    for (var x in itemToDelete) {
      print("${x.toString()}");
      id.add(x.id);
    }

    // gửi xác nhận xóa không
    stdout.write("Bạn có thực sự chắc chắn muốn xóa những sản phẩm này không? (Y/N): ");
    String confirm = stdin.readLineSync() ?? "N";

    if (confirm.toUpperCase() == "Y") {
      int count= targetIds.length;
      // thực hiện xóa các phần tử nằm trong list cần xóa
      l.removeWhere((product) => targetIds.contains(product.id.toLowerCase()));

      print(">> Đã xóa thành công ${count} sản phẩm ${id} ra khỏi hệ thống\n");
      return "Thành công";
    } else {
      print(">> Đã hủy thao tác xóa sản phẩm.\n");
      return "Hủy";
    }
  }

  //_hàm tìm kiếm
  void searchProduct() {
    stdout.write("Nhập từ khóa cần tìm (Mã ID hoặc Tên sản phẩm): ");
    String keyword = stdin.readLineSync() ?? "";
    print('||  ID   ||  Name                       ||  Image         ||  Price   \n'
        '======================================================================');
    bool found = false;
    for (var x in l) {
      if (x.id.toLowerCase().contains(keyword.toLowerCase()) ||
          x.name.toLowerCase().contains(keyword.toLowerCase())) {
        print('||  ${x.id.padRight(4)} ||  ${x.name.padRight(26)} ||  ${(x.image ?? "").padRight(13)} ||  ${x.price}');
        found = true;
      }
    }
    if (!found) {
      print("Không tìm thấy sản phẩm nào trùng khớp với từ khóa: $keyword");
    }
    print("");
  }

  //_get option
  int inputOption(){
    int option;
    while(true){
      try {
        option = int.parse(stdin.readLineSync() ?? "0");
        if (option < 1 || option > 8) {
          stdout.write("Chọn lại option từ 1-8: ");
          continue;
        }
        break;
      } catch (e) {
        print(">> Lỗi: Định dạng không hợp lệ! Vui lòng chỉ nhập số nguyên.");
        stdout.write("Chọn lại option từ 1-8: ");
        continue;
      }
    }return option;
  }


  //_validate
  //_validate name
  String InputName(String oldName) {
    bool isUpdate = oldName.trim().isNotEmpty;
    while (true) {
      stdout.write(isUpdate ? "Nhập tên mới: " : "Nhập tên sản phẩm: ");
      String name = stdin.readLineSync(encoding: utf8) ?? "";

      if (name.trim().isEmpty) {
        print('Tên sản phẩm không được để trống!');
      } else if (name.length < 3) {
        print('Tên sản phẩm phải có ít nhất 3 kí tự!');
      } else {
        return name;
      }
    }
  }

  //_validate image
  String InputImage(String oldImage) {
    bool isUpdate = oldImage.trim().isNotEmpty;
    final forbiddenChars = ['\\', '/', ':', '*', '?', '"', '<', '>', '|'];

    while (true) {
      stdout.write(isUpdate ? "Nhập tên file ảnh mới: " : "Nhập tên file ảnh: ");
      String image = stdin.readLineSync() ?? "";

      if (image.trim().isEmpty) {
        if (isUpdate) {
          return oldImage;
        }
        return "";
      }
      bool hasForbidden = false;
      for (var x in forbiddenChars) {
        if (image.contains(x)) {
          print('Tên file ảnh không cho phép xuất hiện các kí tự: \\/ :*? "<>|');
          hasForbidden = true;
          break;
        }
      }
      if (hasForbidden) continue;


      String low = image.toLowerCase();
      if (low.endsWith('.png') || low.endsWith('.jpeg') || low.endsWith('.jpg') || low.endsWith('.webp')) {
        return image;
      } else {
        print('File ảnh phải có đuôi là .png/ .jpeg/ .jpg/ .webp');
      }
    }
  }

  //_validate price
  double InputPrice(double oldPrice) {
    bool isUpdate = oldPrice > 0;
    while (true) {
      stdout.write(isUpdate ? "Nhập giá sản phẩm mới(VNĐ): " : "Nhập giá sản phẩm(VNĐ): ");
      String input = stdin.readLineSync() ?? "";

      try {
        double price = double.parse(input);
        if (price.isNaN) {
          print('Giá sản phẩm không được để trống!');
        } else if (price <= 0) {
          print('Giá sản phẩm không được nhỏ hơn hoặc bằng 0!');
        } else {
          return price;
        }
      } catch (e) {
        print("Giá sản phẩm phải là một số hợp lệ!");
      }
    }
  }


  bool checkEmpty(String mess) {
    if (l.isEmpty) {
      print("${mess}");
      return true;
    }
    return false;
  }
}
