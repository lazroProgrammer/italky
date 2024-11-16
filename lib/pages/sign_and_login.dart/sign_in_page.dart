import 'package:flutter/material.dart';
//email validation
import 'package:email_validator/email_validator.dart';
//firebase authentication
import 'package:firebase_auth/firebase_auth.dart';
//alerts
import 'package:quickalert/quickalert.dart';
//internal dependancies
import '../../authentication/email authentication/auth.dart';
import 'package:italky2/data%20storage/database/user/user_model.dart';
import 'package:italky2/pages/sign_and_login.dart/custom_fields/custom_field.dart';
import 'package:italky2/connectivity.dart';

bool notShowPassword = true;
bool notShowPassword2 = true;
const double paddingBetweenFields = 20.0;

final formKey = GlobalKey<FormState>();

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool verifiedEmail = false;
  String? errorMessage = '';
  bool addUserInDatabase = true;

  TextEditingController firstNameTEC = TextEditingController();
  TextEditingController lastNameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController password2TEC = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailTEC.text,
        password: passwordTEC.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text:
                'failed to sign in, please check your internet connection ${e.message}');
        addUserInDatabase = false;
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
          title: const Text('Sign in'),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: paddingBetweenFields,
                ),

                //first name
                SignField(
                    validator: (value) {
                      if (value == '') {
                        return 'fill in the blank';
                      } else if (!RegExp(r'^[a-z A-Z]*$')
                          .hasMatch(value ?? '')) {
                        return 'a name does not contain any special characters nor digits';
                      } else {
                        return null;
                      }
                    },
                    controller: firstNameTEC,
                    firstIcon: const Icon(Icons.person),
                    hintText: 'first name'),

                const SizedBox(
                  height: paddingBetweenFields,
                ),

                //last name
                SignField(
                    validator: (value) {
                      if (value == '') {
                        return 'fill in the blank';
                      } else if (!RegExp(r'^[a-z A-Z]*$')
                          .hasMatch(value ?? '')) {
                        return 'a name does not contain any special characters nor digits';
                      } else {
                        return null;
                      }
                    },
                    controller: lastNameTEC,
                    firstIcon: const Icon(Icons.person),
                    hintText: 'last name'),

                const SizedBox(
                  height: paddingBetweenFields,
                ),

                //email
                SignField(
                    validator: (email) {
                      if (email == '') {
                        return 'fill in the blank';
                      }
                      if (email != null && !EmailValidator.validate(email)) {
                        return 'Enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    controller: emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    firstIcon: const Icon(Icons.email),
                    hintText: 'Email'),

                const SizedBox(
                  height: paddingBetweenFields,
                ),

                //password
                SignField(
                  validator: (value) {
                    if (value == '') {
                      return 'fill in the blank';
                    } else if (value != null && value.length < 8) {
                      return 'password should be at least 8 characters';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordTEC,
                  obscureText: notShowPassword,
                  firstIcon: const Icon(Icons.lock),
                  hintText: 'password',
                  secondIcon: togglePassword(notShowPassword, false),
                ),

                const SizedBox(
                  height: paddingBetweenFields,
                ),

                //confirm password
                SignField(
                  validator: (value) {
                    if (value == '') {
                      return 'fill in the blank';
                    } else if (passwordTEC.text != password2TEC.text) {
                      return 'wrong password';
                    } else {
                      return null;
                    }
                  },
                  controller: password2TEC,
                  obscureText: notShowPassword2,
                  firstIcon: const Icon(Icons.lock),
                  hintText: 'confirm password',
                  secondIcon: togglePassword(notShowPassword2, true),
                ),

                const SizedBox(
                  height: paddingBetweenFields,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 134, 17, 141),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          final isValid = formKey.currentState!.validate();
                          if (isValid) {
                            Connection.internetConnection().then((isConnected) {
                              if (isConnected) {
                                createUserWithEmailAndPassword();
                                if (addUserInDatabase) {
                                  UserModel.createUser(
                                      name:
                                          "${firstNameTEC.text} ${lastNameTEC.text}".toLowerCase(),
                                      email: emailTEC.text);
                                  Navigator.of(context).pop();
                                }
                              } else {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text:
                                      'it looks like you don\'t have internet connection please try later',
                                );
                              }
                            });
                          }
                        },
                      );
                    },
                    child: const Text('Sign In')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton togglePassword(bool obscure, bool field) {
    return IconButton(
      onPressed: () {
        setState(() {
          obscure = !obscure;
          if (!field) {
            notShowPassword = !notShowPassword;
          } else {
            notShowPassword2 = !notShowPassword2;
          }
        });
      },
      icon: obscure
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );
  }
}
