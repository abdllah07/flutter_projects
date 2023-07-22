import 'package:firstproje/models/user/user_model.dart';
import 'package:flutter/material.dart';




class UsersScreen extends StatelessWidget{

  List<UserModel> usermodel = [
    UserModel(
        id:1 ,
        phone: "5389370863",
        name: "Abdullah" ,

    ),
    UserModel(
      id:2 ,
      phone: "5389370863",
      name: "hazem " ,

    ),
    UserModel(
      id:3,
      phone: "5389370863",
      name: "Muhammed" ,

    ),
    UserModel(
      id:4,
      phone: "5389370863",
      name: "Ahmet" ,

    ),
    UserModel(
      id:1 ,
      phone: "5389370863",
      name: "Abdullah" ,

    ),
    UserModel(
      id:2 ,
      phone: "5389370863",
      name: "hazem " ,

    ),
    UserModel(
      id:3,
      phone: "5389370863",
      name: "Muhammed" ,

    ),
    UserModel(
      id:4,
      phone: "5389370863",
      name: "Ahmet" ,

    ),
  ];
  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg"),
            ),
            SizedBox(
              width: 15,
            ),
            Text("Users" ,style: TextStyle(color: Colors.black),),
          ],
        ),
        elevation: 0,
        actions: [
          CircleAvatar(
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.camera_alt),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.edit),
            ),
          ),
          SizedBox(
            width: 10,
          ),

        ],
      ),
      body:  ListView.separated(
          itemBuilder: (Context,index)=> BuildItem(usermodel[index]),
          separatorBuilder: (Context , index)=>Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          itemCount:usermodel.length,
      ),


    );

  }

  Widget BuildItem(UserModel user)=> Padding(
    padding: EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: Text(
            '${user.id}',style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${user.name}',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
              '${user.phone}',style: TextStyle(
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),


      ],
    ),
  );
}