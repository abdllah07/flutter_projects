import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firstproje/models/shopApp/EditProfileScreen.dart';
import 'package:firstproje/modules/shopApp/Screens/PmenuWidget.dart';
import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/states.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:firstproje/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSettingsScreen extends StatelessWidget {
  const ShopSettingsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ShopCubit , ShopLayoutStates>(
    listener: (context , state) {
    },
    builder: (context , state) {
      var model = ShopCubit.get(context).userModel!;

      return  ConditionalBuilder(
        condition: ShopCubit.get(context).userModel != null,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Profile", style: Theme.of(context).textTheme.headline4),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [

                  /// -- IMAGE
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset("assets/images/me.jpg"),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.orange),
                          child: const Icon(Icons.verified_user,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(model.data!.name, style: Theme.of(context).textTheme.headline4),
                  Text("SWE", style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 20),

                  /// -- BUTTON
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      } ,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, side: BorderSide.none, shape: const StadiumBorder()),
                      child: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),

                  /// -- MENU
                  ProfileMenuWidget(title: "Settings", icon: Icons.settings, onPress: () {}),
                  ProfileMenuWidget(title: "Billing Details", icon: Icons.info, onPress: () {}),
                  ProfileMenuWidget(title: "User Management", icon: Icons.manage_accounts, onPress: () {}),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(title: "Information", icon: Icons.info, onPress: () {}),
                  ProfileMenuWidget(
                      title: "Logout",
                      icon: Icons.logout,
                      textColor: Colors.orange,
                      endIcon: false,
                      onPress: () {
                        signOut(context);

                      }),
                ],
              ),
            ),
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    } ,

  );



  }



}
