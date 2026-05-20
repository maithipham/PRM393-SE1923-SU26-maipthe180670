import 'dart:io';
import 'package:lab_1_maipthe180670/Entity/product.dart';
import 'package:lab_1_maipthe180670/Repository/productDAO.dart';

void main() {
  productDAO dao = productDAO(Product.productList);
  while (true) {
    //step1: hiển thị menu
    dao.displayForm();

    //step2: nhập option từ bàn phím và kiểm tra
    int option = dao.inputOption();

    //step3: xử lý các case chức năng theo lựa chọn của người dùng
    switch (option) {
    //_hiển thị danh sách sản phẩm
      case 1:
         dao.displayProduct();
        break;

    //_sắp xếp danh sách sản phẩm
      case 2:
        if(dao.checkEmpty("Danh sách đang trống, không thể sắp xếp!\n")) {
          break;
        }
        dao.sortProduct();
        break;

    //_thêm mới sản phẩm vào danh sách
      case 3:
        String res = dao.addProduct();
        if (res == "Thành công") {
          dao.sortProduct(autoNameSort: "id", autoTypeSort: "t");
        }
        break;

    //_sửa thông tin sản phẩm
      case 4:
        if(dao.checkEmpty("Danh sách đang trống, không có sản phẩm để sửa!\n")) {
          break;
        }
        String res = dao.updateProduct();
        if (res == "Thành công") {
          dao.sortProduct(autoNameSort: "id", autoTypeSort: "t");
        }
        break;

    //_xóa sản phẩm khỏi danh sách
      case 5:
        if(dao.checkEmpty("Danh sách đang trống, không có sản phẩm để xóa!\n")) {
          break;
        }
        dao.deleteProduct();
        break;

    //_tìm kiếm sản phẩm
      case 6:
        if(dao.checkEmpty("Danh sách đang trống, không có sản phẩm để tìm kiếm!\n")) {
          break;
        }
        dao.searchProduct();
        break;

    //tăng 10% giá sản phẩm
      case 7:
        dao.increasePrice();
        break;

    //_thoát chương trình
      case 8:
        print(">> Cảm ơn bạn đã sử dụng chương trình. Tạm biệt!");
        return;

      default:
        print("Lựa chọn nằm ngoài danh mục! Vui lòng chọn từ 1 đến 8.");
    }
  }
}




