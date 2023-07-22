import 'package:bloc/bloc.dart';
import 'package:firstproje/modules/archivedtasks/ArchivedTasksScreen.dart';
import 'package:firstproje/modules/donetasks/DoneTasksScreen.dart';
import 'package:firstproje/modules/newtasks/NewTasksScreen.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:firstproje/shared/cubit/states.dart';
import 'package:firstproje/shared/network/local/cash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int current_index = 0;

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = ["Tasks", "Done Tasks", "Archived Tasks"];

  void changeIndex(int index) {
    current_index = index;
    emit(AppChangeBottomNavBarState());
  }
// databases methods

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  late Database db;
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print("Database Created");
        db
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT,date TEXT,  time TEXT,status TEXT)')
            .then((value) {
          print("Table created");
        }).catchError((Error) {
          print("Erorr when creating table ${Error.toString()}");
        });
      },
      onOpen: (db) {
        print("database Opened");
        getFromDatabase(db);
      },
    ).then((value) {
      db = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
            'INSERT INTO tasks (title,date,time,status )VALUES ("$title","$date","$time","NEW")',
          )
          .then((value) => {
                print("$value the insert sql command is done "),
                emit(AppInsertDatabaseState()),
                getFromDatabase(db),
              })
          .catchError((Error) {
        print('erorr wthen inserting ${Error.toString()}');
      });
    });
  }

  void getFromDatabase(db)  {
    newtasks  = [];
    donetasks = [];
    archivetasks = [];

    emit(AppGetDatabaseLoadingState());

    db.rawQuery('SELECT * FROM tasks ').then((value) {

      value.forEach((element) {
        print(value);
        if(element['status'] == 'NEW' ){newtasks.add(element);}
        else if (element['status'] == 'done'){donetasks.add(element);}
        else archivetasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  // change bottom sheets

  void changBottonSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }


  void updateData({
    required String status ,
    required int id ,
})
  async {
      db.rawUpdate(
          "UPDATE tasks SET status = ? WHERE id = ?",
          ["$status","$id"],
      ).then((value)  {
        getFromDatabase(db);
        emit(AppUpdateDatabaseState());
      });
  }
  void deleteData({
    required int id ,
  })
  async {
    db.rawDelete(
      "Delete FROM tasks WHERE id = ?",
      ["$id"],
    ).then((value)  {
      getFromDatabase(db);
      emit(AppDeleteDatabaseState());
    });
  }


  ThemeMode appMode = ThemeMode.light;
  bool isDark = false ;
  void ChangeAppMode({bool? FromShared})
  {
    if(FromShared != null){

      isDark = FromShared;
      emit(AppChangeModeState());

    }else{
      isDark = !isDark;
      CashHelper.putData(key: 'isDark', value: isDark).then((value)  {
        emit(AppChangeModeState());
      });
      }

  }


}
