import 'package:flutter/material.dart';
import 'package:italky2/pages/sign_and_login.dart/login_page.dart';
import'pages/home/home_page.dart';
import 'authentication/email authentication/auth.dart';
import 'package:italky2/data storage/local storage/simple_preferences.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => WidgetTreeState();
}

class WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder:(context, snapshot) {
        if(SimplePreferences.getLogin()??false)
        {
          return const Homepage();
        }
        else{
          return const LoginPage();
        }
      },
    );
  }
}