import 'package:firstproje/modules/shopApp/layout/cubit.dart';
import 'package:firstproje/modules/shopApp/layout/states.dart';
import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EditProfileScreen extends StatelessWidget {
    var NameController = TextEditingController();
    var EmailController = TextEditingController();
    var PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopLayoutStates>(
      listener: (context , state ) {
        if(state is ProfileSuccessState){
          NameController.text = state.loginModel.data!.name;
          EmailController.text = state.loginModel.data!.email;
          PhoneController.text = state.loginModel.data!.phone;
        }
      },
      builder: (context , state){
        var model = ShopCubit.get(context).userModel!;
        NameController.text = model.data!.name;
        EmailController.text =  model.data!.email;
        PhoneController.text =  model.data!.phone;


        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                 if(state is UpdateProfileLoadingState)
                    LinearProgressIndicator(),
                  const SizedBox(height: 10),
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
                          child: const Icon(Icons.edit,
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
                  defaultFormField(
                    controller: NameController,
                    type: TextInputType.text,
                    validate: (value){
                      if(value.isEmpty){
                        return "Title must be not empty ! ";
                      }
                      return null ;
                    },
                    label: "Name",
                    color: Colors.orange,
                    iconP: Icons.text_fields,
                  ),
                  defaultFormField(
                    controller: EmailController,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value.isEmpty){
                        return "Title must be not empty ! ";
                      }
                      return null ;
                    },
                    label: "Email",
                    color: Colors.orange,
                    iconP: Icons.text_fields,
                  ),
                  defaultFormField(
                    controller: PhoneController,
                    type: TextInputType.number,
                    validate: (value){
                      if(value.isEmpty){
                        return "Title must be not empty ! ";
                      }
                      return null ;
                    },
                    label: "Phone",
                    color: Colors.orange,
                    iconP: Icons.text_fields,
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),

                  /// -- MENU
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        ShopCubit.get(context).getUpdateProfileData(
                            name:NameController.text ,
                            email: EmailController.text,
                            phone: PhoneController.text ,
                        );
                      } ,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, side: BorderSide.none, shape: const StadiumBorder()),
                      child: const Text("Save", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
