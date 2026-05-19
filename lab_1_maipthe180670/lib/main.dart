import 'dart:io';
import 'package:lab_1_maipthe180670/product.dart';

void main() {
  while (true) {
    //step1: hiển thị menu
    Product.displayForm();

    //step2: nhập option từ bàn phím và kiểm tra
    int option = Product.inputOption();

    //step3: xử lý các case chức năng theo lựa chọn của người dùng
    switch (option) {
    //_hiển thị danh sách sản phẩm
      case 1:
         Product.displayProduct();
        break;

    //_sắp xếp danh sách sản phẩm
      case 2:
        if(Product.checkEmpty("Danh sách đang trống, không thể sắp xếp!\n")) {
          break;
        }
        Product.sortProduct();
        break;

    //_thêm mới sản phẩm vào danh sách
      case 3:
        String res = Product.addProduct();
        if (res == "Thành công") {
          Product.sortProduct(autoNameSort: "id", autoTypeSort: "t");
        }
        break;

    //_sửa thông tin sản phẩm
      case 4:
        if(Product.checkEmpty("Danh sách đang trống, không có sản phẩm để sửa!\n")) {
          break;
        }
        String res = Product.updateProduct();
        if (res == "Thành công") {
          Product.sortProduct(autoNameSort: "id", autoTypeSort: "t");
        }
        break;

    //_xóa sản phẩm khỏi danh sách
      case 5:
        if(Product.checkEmpty("Danh sách đang trống, không có sản phẩm để xóa!\n")) {
          break;
        }
        Product.deleteProduct();
        break;

    //_tìm kiếm sản phẩm
      case 6:
        if(Product.checkEmpty("Danh sách đang trống, không có sản phẩm để tìm kiếm!\n")) {
          break;
        }
        Product.searchProduct();
        break;

    //_thoát chương trình
      case 7:
        print(">> Cảm ơn bạn đã sử dụng chương trình. Tạm biệt!");
        return;

      default:
        print("Lựa chọn nằm ngoài danh mục! Vui lòng chọn từ 1 đến 7.");
    }
  }
}




