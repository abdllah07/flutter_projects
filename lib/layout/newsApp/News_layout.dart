
import 'package:firstproje/layout/newsApp/cubit/cubit.dart';
import 'package:firstproje/layout/newsApp/cubit/states.dart';
import 'package:firstproje/modules/newsApp/search/searchScreen.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:firstproje/shared/cubit/cubit.dart';
import 'package:firstproje/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class News_Layout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsState>(
      listener:(context,state) {},
      builder: (context , state)
      {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "News App",
            ),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: (){
                AppCubit.get(context).ChangeAppMode();
              }, icon: Icon(Icons.brightness_4_outlined))

            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items:cubit.bottomitems,
            onTap: (index){
              cubit.changeBottomNavBar(index);

            },
          ),
        );
      },
    );
  }
}
