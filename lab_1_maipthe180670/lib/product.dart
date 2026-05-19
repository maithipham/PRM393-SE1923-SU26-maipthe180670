import 'dart:convert';
import 'dart:io';

class Product{
  /*
  Lab 1: Xây dựng lớp Product  (id, name, image, price )
  có các thuộc tính và 1 danh sách tĩnh gồm List<Product>
  và xây dựng các phương thức để
  hiển thị, sắp xếp, thêm, xóa, sửa, tìm kiếm, ....
   */
  late String _id;
  late String _name;
  late String _image;
  late int _price;

  Product({required String id, String name ="", String image="", int price=0}){
    this._id = id;
    this._name = name;
    this._image = image;
    this._price = price;
  }

  static List<Product>  productList = [
    Product(id: "P01", name: "Sữa chua TH True", image: "suachua.png", price: 8500),
    Product(id: "P02", name: "Sữa tươi tiệt trùng", image: "suatuoi.png", price: 32000),
    Product(id: "P03", name: "Bánh mì gối", image: "banhmi.png", price: 25000),
    Product(id: "P04", name: "Kem tràng tiền", image: "kem.png", price: 12000),
    Product(id: "P05", name: "Nước khoáng Aquafina", image: "nuoc.png", price: 5000),
  ];

  //_hàm hiển thị form
  static void displayForm(){
    stdout.write('----------------List product----------------\n'
        '1. Hiển thị danh sách sản phẩm\n'
        '2. Sắp xếp danh sách sản phẩm\n'
        '3. Thêm mới sản phẩm vào danh sách\n'
        '4. Sửa thông tin sản phẩm\n'
        '5. Xóa sản phẩm khỏi danh sách\n'
        '6. Tìm kiếm sản phẩm\n'
        '7. Thoát chương trình\n'
        '--------------------------------------------\n'
        'Chọn 1 option từ 1-7: ');
  }

  //_hàm hiển thị sản phẩm
  static void displayProduct() {
    if (productList.isEmpty) {
      print("Danh sách sản phẩm trống!");
      return;
    }
    print('||  ID   ||  Name                       ||  Image         ||  Price   ');
    print('======================================================================');
    for (var x in productList) {
      print('||  ${x._id.padRight(4)} ||  ${x._name.padRight(26)} ||  ${x._image.padRight(13)} ||  ${x._price}');
    }
    print("\n");
  }

  //_hàm sắp xếp
  static void sortProduct({String? autoNameSort, String? autoTypeSort}){
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
        for(int i =0; i<productList.length-1; i++){
          for(int j=i+1; j< productList.length; j++){

            var valI;
            var valJ;
            switch(nameSort.toLowerCase()){
              case "id":
                valI = productList[i]._id;
                valJ = productList[j]._id;
                break;
              case "name":
                valI = productList[i]._name;
                valJ = productList[j]._name;
                break;
              case "price":
                valI = productList[i]._price;
                valJ = productList[j]._price;
                break;
              default:
                valI = productList[i]._id;
                valJ = productList[j]._id;
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
              var temp = productList[i];
              productList[i] = productList[j];
              productList[j] = temp;
            }
          }
        }
if (autoNameSort == null || autoTypeSort == null) {
  print(
      ">> Danh sách sản phẩm sau khi xếp ${typeSort.toLowerCase().trim() == 't'
          ? 'tăng dần'
          : 'giảm dần'} theo "
          "${nameSort}:");
  Product.displayProduct();
}
  }

  //_hàm thêm sản phẩm mới
  static String addProduct() {
    print("--- THÊM SẢN PHẨM MỚI ---");

    String id;
    while (true) {
      stdout.write("Nhập mã sản phẩm (ID): ");
      id = stdin.readLineSync() ?? "";
      if (id.trim().isEmpty) {
        print("Mã sản phẩm không được để trống!");
      } else if (getInfoByID(id)) {
        print("Mã sản phẩm này đã tồn tại! Vui lòng dùng mã khác.");
      } else {
        break;
      }
    }

    String name;
    while (true) {
      stdout.write("Nhập tên sản phẩm: ");
      name = stdin.readLineSync(encoding: utf8) ?? "";
      String? error = validateName(name);
      if (error != null) {
        print(error);
      } else {
        break;
      }
    }

    String image;
    while (true) {
      stdout.write("Nhập tên file ảnh: ");
      image = stdin.readLineSync() ?? "";
      String? error = validateImage(image);
      if (error != null) {
        print(error);
      } else {
        break;
      }
    }

    int price;
    while (true) {
      stdout.write("Nhập giá sản phẩm(VNĐ): ");
      try {
        price = int.parse(stdin.readLineSync() ?? "0");
        String? error = validatePrice(price);
        if (error != null) {
          print(error);
        } else {
          break;
        }
      } catch (e) {
        print("Giá sản phẩm phải là một số hợp lệ!");
      }
    }

    Product newProduct = Product(id: id, name: name, image: image, price: price);
    productList.add(newProduct);
    print(">> Thêm sản phẩm mới(${name}) thành công!\n");
    return "Thành công";
  }

  //_hàm sửa thông tin sản phẩm
  static String updateProduct() {
    print("--- SỬA THÔNG TIN SẢN PHẨM ---");
    String id;
    while(true){
      stdout.write("Nhập mã ID sản phẩm cần sửa: ");
       id = stdin.readLineSync() ?? "";
      if(getInfoByID(id)){
        break;
      }else{
        print("Không tìm thấy sản phẩm có mã $id!");
    }
      }
    int index = productList.indexWhere((x) => x._id.toLowerCase() == id.toLowerCase());

    Product sp = productList[index];
    print("Thông tin hiện tại: [ID: ${sp._id}, Tên: ${sp._name}, Ảnh: ${sp._image}, Giá: ${sp._price}]");

    // 1. kiểm tra sửa tên
    stdout.write("Nhập tên mới: ");
    String inputName = stdin.readLineSync(encoding: utf8) ?? "";
    if (inputName.trim().isNotEmpty) {
      String? error = validateName(inputName);
      if (error == null) {
        sp._name = inputName;
      } else {
        print(">> Lỗi: $error -> Giữ nguyên tên cũ.");
      }
    }

    // 2. kiểm tra sửa ảnh
    String image;
    while (true) {
      stdout.write("Nhập tên file ảnh mới: ");
      image = stdin.readLineSync() ?? "";
      String? error = validateImage(image);
      if (error != null) {
        print(error);
      } else {
        sp._image = image;
        break;
      }
    }

    // 3. kiểm tra sửa giá
    int price;
    while (true) {
      stdout.write("Nhập giá sản phẩm mới(VNĐ): ");
      try {
        price = int.parse(stdin.readLineSync() ?? "0");
        String? error = validatePrice(price);
        if (error != null) {
          print(error);
        } else {
          sp._price = price;
          break;
        }
      } catch (e) {
        print("Giá sản phẩm phải là một số hợp lệ!");
      }
    }

    print(">> Hoàn tất quá trình cập nhật thông tin sản phẩm ${sp._id}!");
    print("\n");
    return "Thành công";
  }

  //_hàm xóa sản phẩm khỏi danh sách
  static String deleteProduct() {
    print("--- XÓA SẢN PHẨM KHỎI DANH SÁCH ---");
    print("Có thể xóa một hoặc nhiều sản phẩm.");
    List<String> targetIds = [];
    List<Product> itemToDelete = [];
    while(true){
      stdout.write("Nhập mã các sản phẩm cần xóa (cách nhau bởi dấu cách, ví dụ: P01 P03): ");
      String input = stdin.readLineSync() ?? "";

      // tách chuỗi nhập vào thành list danh sách các Id riêng biệt
      targetIds = input.split(" ").where((id) => id.toLowerCase().trim().isNotEmpty).toList();

      // tìm và hiển thị thông tin những sản phẩm sắp bị xóa để kiểm tra thông tin
      itemToDelete = productList.where((p) => targetIds.contains(p._id.toLowerCase())).toList();

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
    for (var x in itemToDelete) {
      print("[ID: ${x._id}, Tên: ${x._name}, Ảnh: ${x._image}, Giá: ${x._price}]");
    }

    // gửi xác nhận xóa không
    stdout.write("Bạn có thực sự chắc chắn muốn xóa những sản phẩm này không? (Y/N): ");
    String confirm = stdin.readLineSync() ?? "N";

    if (confirm.toUpperCase() == "Y") {
      int count= targetIds.length;
      // thực hiện xóa các phần tử nằm trong list cần xóa
      productList.removeWhere((product) => targetIds.contains(product._id.toLowerCase()));

      print(">> Đã xóa thành công ${count} sản phẩm ${targetIds} ra khỏi hệ thống\n");
      return "Thành công";
    } else {
      print(">> Đã hủy thao tác xóa sản phẩm.\n");
      return "Hủy";
    }
  }

  //_hàm tìm kiếm
  static void searchProduct() {
    stdout.write("Nhập từ khóa cần tìm (Mã ID hoặc Tên sản phẩm): ");
    String keyword = stdin.readLineSync() ?? "";
    print('||  ID   ||  Name                       ||  Image         ||  Price   \n'
        '======================================================================');
    bool found = false;
    for (var x in productList) {
      if (x._id.toLowerCase().contains(keyword.toLowerCase()) ||
          x._name.toLowerCase().contains(keyword.toLowerCase())) {
        print('||  ${x._id.padRight(4)} ||  ${x._name.padRight(26)} ||  ${x._image.padRight(13)} ||  ${x._price}');
        found = true;
      }
    }
    if (!found) {
      print("Không tìm thấy sản phẩm nào trùng khớp với từ khóa: $keyword");
    }
    print("");
  }

  //_get trạng thái tồn tại của sản phẩm theo id
  static bool getInfoByID(String id) {
    for (var x in productList) {
      if (id.toLowerCase() == x._id.toLowerCase()) return true;
    }
    return false;
  }

  //_get option
  static int inputOption(){
    int option;
    while(true){
      try {
        option = int.parse(stdin.readLineSync() ?? "0");
        if (option < 1 || option > 7) {
          stdout.write("Chọn lại option từ 1-7: ");
          continue;
        }
        break;
      } catch (e) {
        print(">> Lỗi: Định dạng không hợp lệ! Vui lòng chỉ nhập số nguyên.");
        stdout.write("Chọn lại option từ 1-7: ");
        continue;
      }
    }return option;
  }


  //_validate
  //_validate name
  static String? validateName(String name){
    if(name.trim().isEmpty){
      return 'Tên sản phẩm không được để trống!';
    }
    if(name.length<3){
      return 'Tên sản phẩm phải có ít nhất 3 kí tự!';
    }
    return null;
  }

  //_validate image
  static String? validateImage(String image){
    final list = ['\\', '/', ':', '*', '?', '"', '<', '>', '|'];
    for(var x in list){
      if(image.contains(x)){
        return 'Tên file ảnh không cho phép xuất hiện các kí tự: \\/ :*? "<>|';
      }
    }
    if(image.trim().isEmpty){
      return 'Ảnh sản phẩm không được để trống!';
    }
     if(image.toLowerCase().endsWith('.png') || image.toLowerCase().endsWith('.jpeg') ||
        image.toLowerCase().endsWith('.jpg') || image.toLowerCase().endsWith('.webp') ){
      return null;
    }else{
       return 'File ảnh phải có đuôi là .png/ .jpeg/ .jpg/ .webp';
     }
  }

  //_validate price
  static String? validatePrice(int price){
    if(price.isNaN){
      return 'Giá sản phẩm không được để trống!';
    }
    if(price<=0){
      return 'Giá sản phẩm không được nhỏ hơn hoặc bằng 0!';
    }
    return null;
  }


  static bool checkEmpty(String mess) {
    if (productList.isEmpty) {
      print("${mess}");
      return true;
    }
    return false;
  }
}