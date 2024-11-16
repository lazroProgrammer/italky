import 'package:flutter/material.dart';
import 'package:italky2/pages/home/sidebar pages/friend_requests/friend_requests.dart';
import 'package:italky2/pages/home/sidebar pages/friend_requests/search_friends.dart';

class FriendRequestPage extends StatefulWidget {
  const FriendRequestPage({super.key});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}

class _FriendRequestPageState extends State<FriendRequestPage> {
  int _index = 0;

  final List<Widget> screens = const [FriendRequestsPage(), SeachFriendPage()];

  void _onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: screens,
      ),
       bottomNavigationBar: BottomNavigationBar(currentIndex: _index,
       onTap: _onTabTapped,
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'friend requests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'search for friends',
        ),
      ]),
    );
  }
}
