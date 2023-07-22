import 'package:flutter/material.dart';

class bmiResultScreen extends StatelessWidget {
  final int result ;
  final bool isMale ;
  final int age  ;

  bmiResultScreen({
    required this.age,
    required this.isMale,
    required this.result,
});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "BMI RESULT",
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Gender : ${isMale ? "Male" : "Female"}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              "Result : $result",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              "Age : $age",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),


          ],
        ),
      ),
    );
  }
}
