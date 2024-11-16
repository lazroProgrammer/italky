import 'package:cloud_firestore/cloud_firestore.dart';

class FriendRequest {
  static Future<void> addFriendRequest(
      String receiverId, String senderId, bool requestExists) async {
    final userInstance = FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('friendRequest');

    if (!requestExists) {
      Map<String, dynamic> request = {'uid':senderId, 'status':'pending'};

      await userInstance.add(request);
    }
  }

  static Future<bool> friendRequestExists(
      String receiverId, String senderId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('friendRequest')
          .where('uid', isEqualTo: senderId)
          .limit(
              1) // Limit the result to 1 document (optional, but improves performance)
          .get();

      return snapshot
          .docs.isNotEmpty; // Returns true if a matching document exists
    } catch (e) {
      // Handle any potential errors
      print('Error checking field existence: $e');
      return false;
    }
  }

  static Future<List<String>> getFriendRequests(String uid) async {
    List<String> users = [];
    String pending='pending';
    final QuerySnapshot userRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('friendRequest')
        .where('status', isEqualTo: pending)
        .limit(1)
        .get();
        if(userRef.docs.isNotEmpty){
          print('query result is not empty');
          users= userRef.docs
      .map((documentRef) => documentRef['uid'] as String)
      .toList();
      return users;}
    else{
      print('query result is empty');
      return [];
    }
    //return users;
  }
}
