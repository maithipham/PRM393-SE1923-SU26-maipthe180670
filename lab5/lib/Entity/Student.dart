class Person {
  String pid;
  String pname;
  int age;
  Person({required this.pid, required this.pname, required this.age});
  String printMessage() => "hello person";
}

// Class Data generic
class Data<T> {
  T value; // Thuộc tính lưu trữ dữ liệu generic
  Data(this.value); // Constructor nhận tham số
}


class Student extends Person {
  double gpa;

  Student({
    required super.pid,
    required super.pname,
    required super.age,
    this.gpa = 0,
  });

  @override
  String printMessage() => "hello student";
  //cách 1
  //factory Student.fromJson({"id": "sv01", "name": "Nguyen Van A", "age": 20, "gpa": 3.5});

  //cách 2
   factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      pid: json['id'],
      pname: json['name'] ,
      age: json['age'],
      gpa: (json['gpa']),
    );
  }
}

class Student1 implements Person {
  @override
  String pid;
  @override
  String pname;
  @override
  int age;
  Student1({required this.pid, required this.pname, this.age = 0});

  @override
  String printMessage() => "Hello student1";
}

void main(){
  var base = [1,2,4,5,7];
  var x = [...base, for(var i in base){if(i%2==0)i}, for(var i in base){if(i%2!=0)i}];
  print(x);
  Map<String, dynamic> mockJson = {
    "id": "SV01",
    "name": "Nguyen Van A",
    "age": 20,
    "gpa": 3.6
  };
  Data<Student> data = Data(Student.fromJson(mockJson));
}