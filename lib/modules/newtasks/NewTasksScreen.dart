import 'package:firstproje/shared/components/components.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:firstproje/shared/cubit/cubit.dart';
import 'package:firstproje/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit , AppStates>(
      listener:(context,state) => {},
      builder: (context , state) {
        var tasks = AppCubit.get(context).newtasks;
        return TasksBulider(tasks: tasks);
      }
    );

  }
}
