import 'package:flutter/material.dart';



class Messenger extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

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
            Text("Chats" ,style: TextStyle(color: Colors.black),),
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 15,),
                      Text("Search"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index ) => bulidStoryItem(),
                    separatorBuilder: (context , index)=>const SizedBox(
                      width: 20,
                    ),
                    itemCount: 7,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context , index)=> buildItemChat(),
                    itemCount: 15,
                    separatorBuilder: (context , index)=>const SizedBox(
                      height: 10,
                    ),
                ),
              ],
            ),
          ),
        ),

    );

  }




  // arrow Function
  Widget buildItemChat() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg"),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 3,
              end: 3,
            ),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hazem Alhasan",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,

              ),
            ),
            Row(
              children: [
                Text("I\t'm Coming"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
                Text(

                  "11:50",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black26 ,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget bulidStoryItem() => Container(
    width: 60,
    child: const Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg"),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 3,
                end: 3,
              ),
              child: CircleAvatar(
                radius: 7.0,
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          "Abdullah Mustafa Alhasan",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
