import 'package:flutter/material.dart';
import 'package:pert6/pages/home_page.dart';
import 'package:pert6/pages/register_page.dart';
import 'package:pert6/providers/auth_provider.dart';
// import 'package:pert6/repository/auth_repository.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final authProvider = Provider.of<AuthProvider>(context);
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Future<void> login() async {
    //   String username = usernameController.text;
    //   String password = passwordController.text;

    //   try {
    //     await authRepository.login(username: username, password: password);

    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //           builder: (_) => const HomePage(),
    //         ),
    //         (route) => false);
    //   } catch (error) {
    //     print("Error $error");
    //   }
    // }

    if (authProvider.loggedInUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      });
    }

    return Scaffold(
      body: Center(
        
          child: Padding(
            
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
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
                  child:const Text('Login', style: TextStyle(fontSize: 16,)),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authProvider.login(
                        usernameController.text,
                        passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade300),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text("Don\'t have account? Register here"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
