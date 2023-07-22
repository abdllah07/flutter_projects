

// ignore_for_file: empty_constructor_bodies

class shopLoginModel{
   bool ? status;
   String ?  message;
  UserData ? data ;

  shopLoginModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;

  }


}

class UserData{
   int ? id;
    late  String  name ;
   late String  email;
   late String  phone ;
   late String   image ;
  int ? points;
  int ? credit ;
  String ? token ;




   UserData.fromJson(Map<String,dynamic> json)
   {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    token = json['token'];
    credit = json['credit'];
  }
}