import 'package:firstproje/modules/counter/cubit/cubit.dart';
import 'package:firstproje/modules/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class counterScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => counter_cubit(),
      child: BlocConsumer<counter_cubit,counter_states>(
        listener:(context,state){},
        builder: (context,state) {
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
                  Text("Counter" ,style: TextStyle(color: Colors.black),),
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
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      counter_cubit.get(context).minus();

                    },
                    child: const Text(
                      "min" ,
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    '${counter_cubit.get(context).counter}',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: (){
                     counter_cubit.get(context).plus();
                    },
                    child: const Text(
                      "plus",
                      style: TextStyle
                        (
                          fontSize: 30
                      ),
                    ),
                  ),

                ],
              ),
            ),

          );
        },
      ),
    );
  }
}
