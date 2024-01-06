// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pert6/pages/home_page.dart';
import 'package:pert6/pages/login_page.dart';
import 'package:pert6/providers/auth_provider.dart';
import 'package:pert6/repository/auth_repository.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final authProvider = Provider.of<AuthProvider>(context);
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    // Future<void> register() async {
    //   String username = usernameController.text;
    //   String password = passwordController.text;
    //   String name = nameController.text;

    //   try {
    //     await authRepository.register(
    //         username: username, password: password, name: name);
    //   } catch (error) {
    //     print("Error $error");
    //   }
    // }

    if (authProvider.loggedInUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
      });
    }

    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'johndoe',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'johndoe',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: '',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  child: const Text('Register', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade300),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authProvider.register(
                        nameController.text,
                        usernameController.text,
                        passwordController.text,
                      );
                    }
                  },
                ),
                
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginPage(),
                      ),
                      (route) => false);
                },
                child: const Text("Already have account? Login here"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
