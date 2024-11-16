import 'dart:async';

import 'package:flutter/material.dart';

import 'package:italky2/pages/sign_and_login.dart/sign_in_page.dart';
import 'package:italky2/data storage/local storage/simple_preferences.dart';
import 'package:italky2/connectivity.dart';
//authentication
import 'package:firebase_auth/firebase_auth.dart';
import '../../authentication/email authentication/auth.dart';

import 'package:quickalert/quickalert.dart';

const paddingBetweenFields = 20.0;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  TextEditingController emailTec = TextEditingController();
  TextEditingController passwordTec = TextEditingController();

  Future<void> loginWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailTec.text,
        password: passwordTec.text,
      );
      SimplePreferences.setLogin(true);
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'you have entered wrong input',
            );
            // Handle the case where the user is not found
            break;
          case 'wrong-password':
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'you have entered wrong input.',
            );
            break;
          case 'invalid-email':
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'you have entered wrong input.',
            );
            break;
          case 'user-disabled':
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'user disabled.',
            );
            break;
          case 'user-token-expired':
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'user token has expired.',
            );
            break;
          case 'too-many-requests':
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'we are high in traffic, try again later.',
            );
            break;
          case 'operation-not-allowed':
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'you have entered wrong input',
            );
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(168, 255, 0, 251),
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'images/italky2.png',
                ),
              ),
              TextField(
                controller: emailTec,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: paddingBetweenFields,
              ),
              TextField(
                controller: passwordTec,
                obscureText: notShowPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: togglePassword(),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Sign up Button
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 155, 24, 167),
                      ),
                      //backgroundColor: MaterialStatePropertyAll(
                      //  Color.fromARGB(255, 134, 17, 141),
                      //),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SignInPage();
                          },
                        ),
                      );
                    },
                    child: const Text('Sign up'),
                  ),

                  // login Button

                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 134, 17, 141),
                      ),
                    ),
                    onPressed: () {
                      Connection.internetConnection().then(
                        (value) async {
                          if (value) {
                            try {
                              await loginWithEmailAndPassword().timeout(
                                const Duration(seconds: 5),
                                onTimeout: () {
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text:
                                          'connection timed out, please try again later');
                                },
                              );
                            } on TimeoutException catch (_) {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text:
                                      'connection timed out, please try again later');
                            }
                          } else {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: 'please check your internet connection');
                          }
                        },
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            notShowPassword = !notShowPassword;
          });
        },
        icon: notShowPassword
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility));
  }
}
