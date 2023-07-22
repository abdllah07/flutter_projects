import 'package:firstproje/shared/components/components.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => null,
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: const Text(
            "Bisoft Shop",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => null,
              icon: const Icon(
                Icons.notification_add,
                color: Colors.white,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: IconButton(
                onPressed: () => null,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 20,
          backgroundColor: Colors.orange,
          shadowColor: Colors.red,
        ),
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
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/005/879/539/original/cloud-computing-modern-flat-concept-for-web-banner-design-man-enters-password-and-login-to-access-cloud-storage-for-uploading-and-processing-files-illustration-with-isolated-people-scene-free-vector.jpg'),
                    ),
                    const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefultButton(
                      width: 200,
                      text: 'login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(emailController);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don\'t have an Account ? "),
                        TextButton(
                            onPressed: () {}, child: Text('Register Now'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
