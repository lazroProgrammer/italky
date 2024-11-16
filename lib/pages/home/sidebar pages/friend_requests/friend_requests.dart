import 'dart:async';

import 'package:flutter/material.dart';
import 'package:italky2/data storage/database/friend requests/friend_requests.dart';
import 'package:italky2/data storage/local storage/simple_preferences.dart';
import 'package:italky2/data%20storage/database/user/user_model.dart';
import 'package:italky2/pages/home/sidebar%20pages/settings_pages/icon_widget.dart';
import 'package:quickalert/quickalert.dart';

class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({super.key});

  @override
  State<FriendRequestsPage> createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequestsPage> {
  List<String> usersID = [];
  List<UserModel> users = [];
  Future<void> getUsersID() async {
    print('getUsersID start: ${DateTime.now()}');

      FriendRequest.getFriendRequests(SimplePreferences.getUserId() ?? '')
          .then((value) {
        usersID = value;
      });
        setState(() {});
        print('userID value ${usersID[0]}');
    print('getUsersID finish: ${DateTime.now()}');
  }

  Future<void> getUsers() async {
    print('getUsers start: ${DateTime.now()}');
    if (usersID.isEmpty) {
      print('senderID: ${SimplePreferences.getUserId()}');
      print('no users');
      return;
    }
    else{
    // for (var element in usersID) {
      UserModel user = await UserModel.getUserData('<id>', usersID[0]);

        print(user.id);

        users.add(user);
        //}
     }
    
    print('getUsers finish: ${DateTime.now()}');
                  setState(() { });
  }

  @override
  void initState() {
    super.initState();
    initializeData().then((value) => null);

    /* const Duration updateInterval = Duration(seconds: 15); // Set the desired update interval
    Timer.periodic(updateInterval, (Timer timer) {
      // Call the method that updates the state
      _updatePeriodically();
    });*/
  }

  /*void _updatePeriodically() {
    // Place your code here to fetch updated data and update the state
    // For example, you can call getUsersID() and getUsers() again

        // Call getUsers() with the updated usersID
        getUsers().then((value) => null);
            setState(() {});
    }*/

  Future<void> initializeData() async {
    await getUsersID();
    await getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('friend requests')),
      body: SafeArea(
        child: ListView.builder(
          itemCount:users.isEmpty?0:users.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const IconWidget(
                  color: Colors.blue,
                  icon: Icons.person,
                ),
                title: const Text(/*users[index].name*/'not good'),
                subtitle: const Text(/*users[index].email*/'not good'),
                onTap: () {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      title: 'add friend?',
                      titleColor: Colors.green,
                      text: 'do you want to add ');
                      /*${users[index].email}*/ 
                      
                });
          },
        ),
      ),
    );
  }
}
