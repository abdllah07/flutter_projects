import 'package:firstproje/modules/archivedtasks/ArchivedTasksScreen.dart';
import 'package:firstproje/modules/donetasks/DoneTasksScreen.dart';
import 'package:firstproje/modules/newtasks/NewTasksScreen.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:firstproje/shared/cubit/cubit.dart';
import 'package:firstproje/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';


class HomeLayout extends StatelessWidget {

    var scaffold_key = GlobalKey<ScaffoldState>();
    var Form_key = GlobalKey<FormState>();
    var title_Controller  = TextEditingController();
    var time_Controller  = TextEditingController();
    var date_Controller  = TextEditingController();


    @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (BuildContext context ,AppStates state ) {
            if (state is AppInsertDatabaseState){
              Navigator.pop(context);
            }
          } ,
          builder: (context , state)
          {
            AppCubit cubit = AppCubit.get(context);
            return  Scaffold(
              key: scaffold_key,
              appBar: AppBar(
                backgroundColor:Colors.teal,
                 title: Center(
                   child: Text(
                      cubit.titles[cubit.current_index],
                ),
                 ),
              ),
              //tasks.length == 0 ? Center(child: CircularProgressIndicator()) :
              body:  state == AppGetDatabaseLoadingState() ? Center(child: CircularProgressIndicator()) :cubit.Screens[cubit.current_index],
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                onPressed: (){
                  if(cubit.isBottomSheetShown)
                  {
                    if(Form_key.currentState!.validate())
                    {
                      cubit.insertToDatabase(
                          title: title_Controller.text,
                          time: time_Controller.text,
                          date: date_Controller.text,
                      );
                    }
                  }
                  else{
                    scaffold_key.currentState?.showBottomSheet(
                            (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: Form_key,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: title_Controller,
                                  type: TextInputType.text,
                                  validate: (value){
                                    if(value.isEmpty){
                                      return "Title must be not empty ! ";
                                    }
                                    return null ;
                                  },
                                  label: "Task Title ",
                                  iconP: Icons.title,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  controller: time_Controller,
                                  ontap: (){
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      time_Controller.text = value!.format(context).toString();
                                    });

                                  },
                                  type: TextInputType.datetime,
                                  validate: (value){
                                    if(value.isEmpty){
                                      return "time must be not empty ! ";
                                    }
                                    return null ;
                                  },
                                  label: "Task Time",
                                  iconP: Icons.timer,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  controller: date_Controller,
                                  ontap: (){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2024-12-12"),
                                    ).then((value) => {
                                      date_Controller.text = DateFormat.yMMMd().format(value!),
                                    });
                                  },
                                  type: TextInputType.datetime,
                                  validate: (value){
                                    if(value.isEmpty){
                                      return "date must be not empty ! ";
                                    }
                                    return null ;
                                  },
                                  label: "Task date",
                                  iconP: Icons.calendar_today,
                                ),

                              ],
                            ),
                          ),
                        ),
                        elevation: 25.0
                    ).closed.then((value)
                    {
                      cubit.changBottonSheetState(
                          isShow: false,
                          icon: Icons.edit,
                      );
                    });
                    cubit.changBottonSheetState(
                        isShow: true,
                        icon: Icons.add,
                    );

                  }
                },
                child:Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: AppCubit.get(context).current_index,
                onTap: (index)
                {

                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.task , color: Colors.teal,),
                    label: "New Tasks",

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle, color: Colors.teal,),
                    label: "Done",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive, color: Colors.teal,),
                      label: "Archived"
                  ),
                ],

              ),
            );
          },

        ),
      );
    }


}


