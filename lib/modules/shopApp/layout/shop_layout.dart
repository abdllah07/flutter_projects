import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firstproje/modules/shopApp/Screens/drawerP/drawer.dart';
import 'package:firstproje/modules/shopApp/Search/searchScreen.dart';
import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/states.dart';
import 'package:firstproje/modules/shopApp/login/loginScreen.dart';
import 'package:firstproje/modules/shopApp/shared/network/local/Shopcash_helper.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopLayoutStates>(
      listener: (context,index) {},
      builder: (context , index) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Shopping",
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    //navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
              ),
            ],
          ),
            drawer: const CustomDrawer(),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: Container(
            height: 80,
            padding: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CurvedNavigationBar(
                  height: 50,
                  backgroundColor: Colors.white,
                  color: Colors.white,

                  onTap: (index){
                    cubit.changeBottom(index);
                  },

                  buttonBackgroundColor: Colors.orange.shade100,

                  items: <Widget>[
                    Icon(Icons.home),
                    Icon(Icons.apps),
                    Icon(Icons.favorite),
                    Icon(Icons.settings)
                  ] ,
              ),

            ),

          )

        );
      },
    );
  }
}




