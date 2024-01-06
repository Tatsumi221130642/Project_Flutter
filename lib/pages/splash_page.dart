import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pert6/pages/home_page.dart';
import 'package:pert6/pages/login_page.dart';
import 'package:pert6/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authProvider.checkAccessToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (authProvider.loggedInUser != null) {
                Future.delayed(const Duration(seconds: 3), () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                  );
                });
              } else {
                Future.delayed(const Duration(seconds: 3), () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  });
                });
              }
            }
            // return const CircularProgressIndicator();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.blue.shade400,
                    size: 50,
                  ),
                  const SizedBox(height: 10,),
                  Text('Please wait...',
                  style: TextStyle(fontSize: 10, color: Colors.blue.shade400),)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
