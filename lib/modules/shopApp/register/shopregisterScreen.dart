import 'package:firstproje/modules/shopApp/layout/shop_layout.dart';
import 'package:firstproje/modules/shopApp/login/cubit.dart';
import 'package:firstproje/modules/shopApp/login/states.dart';
import 'package:firstproje/modules/shopApp/register/cubit.dart';
import 'package:firstproje/modules/shopApp/register/states.dart';
import 'package:firstproje/modules/shopApp/shared/network/local/Shopcash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessState) {
              if (state.RegisterModel!.status!) {
                ShowToast(
                  text: state.RegisterModel!.message!,
                  state: ToastStates.SUCCESS,
                );
                ShopCashHelper.saveData(
                        key: "token", value: state.RegisterModel!.data!.token)
                    .then((value) {
                  NavigateAndFinish(context, ShopLayout());
                });
              } else {
                ShowToast(
                  text: state.RegisterModel!.message!,
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      // to sulation the error when open the keyboard
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Image(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://static.vecteezy.com/system/resources/previews/005/879/539/original/cloud-computing-modern-flat-concept-for-web-banner-design-man-enters-password-and-login-to-access-cloud-storage-for-uploading-and-processing-files-illustration-with-isolated-people-scene-free-vector.jpg'),
                            ),
                            const Text(
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Register now to browse our hot offers",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "The name must be not empty";
                                }
                              },
                              label: "Name",
                              iconP: Icons.drive_file_rename_outline,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "The email must be not empty";
                                }
                              },
                              label: "Email",
                              iconP: Icons.email_outlined,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              isPassword: true,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "The password must be not empty";
                                }
                              },
                              label: "password",
                              iconP: Icons.lock,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "The Phone must be not empty";
                                }
                              },
                              label: "Phone",
                              iconP: Icons.call,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            state is ShopRegisterLoadingState
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : DefultButton(
                                    width: 150,
                                    text: 'Register',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        ShopRegisterCubit.get(context)
                                            .userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
