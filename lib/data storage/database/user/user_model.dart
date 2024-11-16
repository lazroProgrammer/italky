import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String name;

  UserModel({required this.email, required this.name, required this.id});

//creates the user in firestore(in the sign-in page)
  static Future<void> createUser(
      {required String name, required String email}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    docUser.collection('friendRequest');
    docUser.collection('friends');
    docUser.collection('conversations');

    final json = {
      'email': email,
      'name': name,
    };
    await docUser.set(json);
  }

//return the user model object (used in the class)
  factory UserModel.fromJson(Map<String, dynamic> json, String uid) {
    return UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      id: uid,
    );
  }

//return one user (used for fetching the profile data)
  static Future<UserModel> getUserData(
      String fieldName, dynamic fieldValue) async {

    if (fieldName == '<id>') {
final querySnapshot=await FirebaseFirestore.instance.collection('users').doc(fieldValue.toString()).get();
if(querySnapshot.exists){
  return UserModel.fromJson(
          querySnapshot.data() as Map<String, dynamic>, querySnapshot.id);

}else{
  return UserModel(email: '', name: '', id: '');
}
    } else {
    final  querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(fieldName, isEqualTo: fieldValue)
          .limit(1)
          .get();

           if (querySnapshot.docs.isNotEmpty) {
      final documentSnapshot = querySnapshot.docs.first;
      return UserModel.fromJson(
          documentSnapshot.data(), documentSnapshot.id);
    } else {
      return UserModel(email: '', name: '', id: '');
    }
    }
   
  }

//return a list of users(used in friend_search)
  static Future<List<UserModel>> getListUserData(
      String fieldName, dynamic fieldValue,
      {int items = 1}) async {
    QuerySnapshot querySnapshot;
    if (fieldName == 'name') {
      querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(fieldName, isGreaterThanOrEqualTo: fieldValue.toString())
          .where(fieldName,
              isLessThan: changeLastCharacter(fieldValue.toString()))
          .limit(items)
          .get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(fieldName, isEqualTo: fieldValue)
          .limit(items)
          .get();
    }

    List<UserModel> userList = [];

    if (querySnapshot.docs.isNotEmpty) {
      for (var documentSnapshot in querySnapshot.docs) {
        UserModel user = UserModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>,
            documentSnapshot.id);
        userList.add(user);
      }
    }

    return userList;
  }
}

String changeLastCharacter(String input) {
  if (input.isEmpty) {
    // Handle empty string case if needed
    return input;
  }

  List<String> characters =
      input.split(''); // Convert the string to a list of characters
  String lastCharacter = characters.last; // Get the last character
  int nextCharCode = lastCharacter.codeUnitAt(0) +
      1; // Get the ASCII code of the next character
  String nextCharacter =
      String.fromCharCode(nextCharCode); // Convert ASCII code to character
  characters[characters.length - 1] =
      nextCharacter; // Replace the last character
  return characters.join(); // Convert the list back to a string
}
