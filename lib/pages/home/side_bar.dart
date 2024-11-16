import 'package:flutter/material.dart';
import 'package:italky2/pages/home/sidebar%20pages/friend_request_page.dart';
import 'package:italky2/pages/home/sidebar%20pages/settings_page.dart';

//firebase email authentication
import 'package:firebase_auth/firebase_auth.dart';
import 'package:italky2/authentication/email%20authentication/auth.dart';
//for good looking alerts
import 'package:quickalert/quickalert.dart';

import 'package:italky2/data%20storage/database/user/user_model.dart';

//for local storage
import 'package:italky2/data storage/local storage/simple_preferences.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late UserModel userAccount=UserModel(email: "", name: "", id: "");
  bool isLoading = true;

//user data retrieve
  Future<void> _getUserData() async {
    final name = SimplePreferences.getUsername();
    final emailFromPrefs = SimplePreferences.getUserEmail();
    final id= SimplePreferences.getUserId();
    if (name != null && emailFromPrefs != null) {
      //get it from cache
      setState(() {
        userAccount = UserModel(name: name, email: emailFromPrefs,id:id);
        isLoading = false;
      });
    } else {
      //get it from firebase
      final User? user = Auth().currentUser;
      final String email = user?.email?.toLowerCase() ?? '';
      final userAccount = await UserModel.getUserData('email', email);
      setState(() {
        this.userAccount = userAccount;
        isLoading = false;
      });

       SimplePreferences.setUsername(userAccount.name);
       SimplePreferences.setUserEmail(userAccount.email);
       SimplePreferences.setUserId(userAccount.id);
    }
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }


//The main function for the sideBar UI
  @override
  Widget build(BuildContext context) {
    return isLoading
    ?const Drawer(child:Center(child: CircularProgressIndicator.adaptive(),),)
        // ? Drawer(
        //     child: ListView(
        //       padding: EdgeInsets.zero,
        //       children:[
          //       const ListTile(
          //         title:Text("Failed to retrieve Data",style: TextStyle(color:Colors.red),)
          //       ),
          //       const Divider(),
          //       const SizedBox(height: 100,
          //       child: Center(child: CircularProgressIndicator(),),),
          //       const Divider(),
               
                 
                  
          //       ListTile(
          //         leading: const Icon(Icons.person),
          //         title: const Text('Profile'),
          //         onTap: () {},
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.notifications),
          //         title: const Text('notification'),
          //         onTap: () {},
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.chat_bubble),
          //         title: const Text('Friend requests'),
          //         onTap: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (BuildContext context) =>
          //                   const FriendRequestPage(),
          //             ),
          //           );
          //         },
          //       ),
          //       const Divider(),
          //       ListTile(
          //         leading: const Icon(Icons.settings),
          //         title: const Text('Settings'),
          //         onTap: () {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (BuildContext context) {
          //                 return const SettingsPage();
          //               },
          //             ),
          //           );
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.exit_to_app),
          //         title: const Text('Log out'),
          //         onTap: () {
          //           QuickAlert.show(
          //             context: context,
          //             type: QuickAlertType.confirm,
          //             text: "do you want to logout ?",
          //             confirmBtnText: "Yes",
          //             onConfirmBtnTap: () {
          //               signOut();
          //               Navigator.of(context).pop();
          //             },
          //             cancelBtnText: "No",
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // )
        : Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userAccount.name),
                  accountEmail: Text(userAccount.email),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset(
                        'images/girl-profile.png',
                        width: 99,
                        height: 99,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/profile-bg3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('notification'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.chat_bubble),
                  title: const Text('Friend requests'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const FriendRequestPage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const SettingsPage();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Log out'),
                  onTap: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: "do you want to logout ?",
                      confirmBtnText: "Yes",
                      onConfirmBtnTap: () {
                        SimplePreferences.setUsername(null);
                        SimplePreferences.setUserEmail(null);
                        SimplePreferences.setUserId(null);
                        SimplePreferences.setLogin(false);
                        signOut();
                        Navigator.of(context).pop();
                      },
                      cancelBtnText: "No",
                    );
                  },
                ),
              ],
            ),
          );
  }
}
