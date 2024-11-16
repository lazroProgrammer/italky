
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:italky2/data storage/database/user/user_model.dart';

class Conversation{
    final UserModel firstUser;
    final UserModel secondUser;
    final String conversationId;


    Conversation({required this.firstUser,required this.secondUser, required this.conversationId});

static Future<String> createConversation(String firstId, String secondId)async{
  Map<String,dynamic> data={
'firstId': firstId,
'secondId': secondId,
  };
 DocumentReference conversationPath=await FirebaseFirestore.instance.collection('conversations').add(data);
  String conversationId= conversationPath.id;
  conversationPath.collection('messages');

  return conversationId;


}

}
