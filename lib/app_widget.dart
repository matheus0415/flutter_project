import 'package:helloworld/pages/home_page.dart';
import 'package:helloworld/pages/login_page.dart';
import 'package:helloworld/pages/splash_page.dart';
import 'package:helloworld/pages/lembrete_page.dart';
import 'package:helloworld/routes.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lembretes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.INITIAL: (context) => const SplashPage(),
        Routes.LOGIN: (context) => const LoginPage(),
        Routes.HOME: (context) => const HomePage(),
        Routes.LEMBRETES: (context) => const LembretePage(),
      },
      initialRoute: Routes.INITIAL,
    );
  }
}
