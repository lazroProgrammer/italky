import 'package:flutter/material.dart';

import 'package:italky2/data storage/database/user/user_model.dart';
import 'package:italky2/data storage/database/friend requests/friend_requests.dart';
import 'package:italky2/data%20storage/local%20storage/simple_preferences.dart';
import 'package:italky2/pages/home/sidebar%20pages/settings_pages/icon_widget.dart';
import 'package:quickalert/quickalert.dart';

class SeachFriendPage extends StatefulWidget {
  const SeachFriendPage({super.key});

  @override
  State<SeachFriendPage> createState() => _SeachFriendPageState();
}

class _SeachFriendPageState extends State<SeachFriendPage> {
  List<UserModel> suggestionList = [];
  TextEditingController requestController = TextEditingController();
  String previousRequest = 'a';
  bool unChanged = true;
  List<MaterialColor> colors = [
    Colors.red,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.teal,
    Colors.deepOrange,
  ];
  int? colorIndex = SimplePreferences.getColorOfFriendRequest() ?? 0;

  Future<List<UserModel>> _onSubmitSearch(List<UserModel> suggestionList,
      TextEditingController requestController) async {
    if (requestController.text.contains('@')) {
      UserModel temp = await UserModel.getUserData(
          'email', requestController.text.toLowerCase());
      suggestionList.add(temp);
    } else {
      suggestionList = await UserModel.getListUserData(
          'name', requestController.text.toLowerCase(),
          items: 10);
    }
    previousRequest = requestController.text;
    return suggestionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("search"),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  if (value == requestController.text) {
                    setState(() {
                      unChanged = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search by Email or Name",
                  fillColor: Colors.amber,
                  suffixIcon: IconButton(
                    onPressed:
                        (requestController.text == previousRequest && unChanged)
                            ? null
                            : () async {
                                suggestionList = await _onSubmitSearch(
                                    suggestionList, requestController);
                                setState(() {});
                              },
                    icon: const Icon(Icons.send),
                  ),
                ),
                controller: requestController,
                onEditingComplete: (requestController.text == previousRequest)
                    ? null
                    : () async {
                        suggestionList = await _onSubmitSearch(
                            suggestionList, requestController);
                        setState(
                          () {},
                        );
                      },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: suggestionList.isEmpty ? 0 : suggestionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserModel user = suggestionList[index];
                    colorIndex = colorIndex! + 1;
                    if (colorIndex! >= colors.length) colorIndex = 0;
                    SimplePreferences.setFriendReqColor(colorIndex);

                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconWidget(
                          color: colors[colorIndex!],
                          icon: Icons.person,
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        onTap: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            title: 'Friend Request?',
                            titleColor: Colors.green,
                            text:
                                'do you want to send friend request to ${suggestionList[index].email}',
                            onConfirmBtnTap: () {
                              FriendRequest.friendRequestExists(
                                      suggestionList[index].id ?? '',
                                      SimplePreferences.getUserId() ?? '')
                                  .then((value) {
                                FriendRequest.addFriendRequest(
                                    suggestionList[index].id ?? '',
                                    SimplePreferences.getUserId() ?? '',
                                    value);
                                Navigator.of(context).pop();
                                if (value) {
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.info,
                                      text:
                                          'you have already sent a friend request to ${suggestionList[index].email}');
                                }
                              });
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
