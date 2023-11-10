import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/user_model.dart';

class UserApi{
  static final collectionRef = FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(String uid, String email, String name) async{
    await collectionRef.doc(uid).set({
      'email': email,
      'name': name,
    });
  }

  static Future<UserModel> getUser(String uid) async{
    final doc = await collectionRef.doc(uid).get();
    return UserModel.fromJson(doc.data()!);
  }

  static Future<void> updateUser({required UserModel userModel}) async{
    await collectionRef.doc(userModel.id??"").update({
      'name': userModel.name,
      'email': userModel.email,
      'phone': userModel.phone,
    });
  }
}