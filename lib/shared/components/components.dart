import 'dart:ffi';

import 'package:firstproje/layout/newsApp/cubit/cubit.dart';
import 'package:firstproje/layout/newsApp/cubit/states.dart';
import 'package:firstproje/modules/newsApp/webview/webViewScreen.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:firstproje/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

Widget DefultButton({
  double width = double.infinity,
  Color background = Colors.orange,
  required final VoidCallback onPressed,
  required String text,
  bool isUpperCsae = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: background,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: onPressed,
        color: background,
        child: Text(
          isUpperCsae ? text.toUpperCase() : text,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required final validate,
  required String label,
  required IconData iconP,
  final ontap,
  final onsubmit,
  final onChange,
  final Color color = Colors.teal,
  bool isClickable = true,
  bool isPassword = false,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: TextFormField(
        onTap: ontap,
        onFieldSubmitted: onsubmit,
        controller: controller, //to save a input in the variable
        keyboardType: type,
        validator: validate,
        obscureText: isPassword,
        enabled: isClickable,
        onChanged: onChange,
        decoration: InputDecoration(
          prefixIcon: Icon(iconP),
          labelText: label,
          labelStyle: TextStyle(color: color),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            gapPadding: 10.0,
          ),
        ),
      ),
    );

Widget defualtTextButton({
  required final function,
  required String text,
  Color color = Colors.deepOrange,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
      background: Container(color: Colors.teal),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          child: Row(
            children: [
              Container(
                width: 130,
                child: AvatarGlow(
                  glowColor: Colors.lightGreen,
                  endRadius: 90.0,
                  duration: Duration(milliseconds: 4000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text(
                        '${model['time']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      radius: 40.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${model['title']}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${model['date']}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: "done",
                    id: model['id'],
                  );
                },
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.teal,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: "archive",
                    id: model['id'],
                  );
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget TasksBulider({
  required List<Map> tasks,
}) =>
    tasks.length > 0
        ? ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => MyDivider(color: Colors.teal),
            itemCount: tasks.length,
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 50,
                  color: Colors.teal,
                ),
                Text(
                  "No Tasks Yet ):",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          );

// New App
Widget MyDivider({
  required Color color,
}) =>
    Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: color,
      ),
    );

Widget articleBuilder(list, context, state) => state is NewsGetSporsLoadingState
    ? Center(
        child: CircularProgressIndicator(),
      )
    : ListView.separated(
        itemBuilder: (context, index) => bulidarticleItem(list[index], context),
        separatorBuilder: (context, index) => MyDivider(color: Colors.grey),
        itemCount: list.length,
        physics: BouncingScrollPhysics(),
      );

Widget bulidarticleItem(busines, context) => InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(busines['urlToImage'] ??
                      'https://static.vecteezy.com/system/resources/thumbnails/004/216/831/original/3d-world-news-background-loop-free-video.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${busines['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${busines['publishedAt']}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void NavigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

void ShowToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ChoseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color ChoseToastColor(ToastStates state) {
  Color color ;
  switch (state) {
    case ToastStates.SUCCESS:
      color=  Colors.orange;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return  color;
}
