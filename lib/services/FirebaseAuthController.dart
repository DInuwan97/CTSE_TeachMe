import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teachme/Models/User.dart';

class FirebaseAuthController {
  final String fireStoreCollectionNameUser = "Users";

  //add new teacher
  addNew(User user) async {
    await FirebaseFirestore.instance
        .collection(fireStoreCollectionNameUser)
        .doc()
        .set(user.toJson());
  }

  //log user
  signin() async {
    print('signin called');
    return await FirebaseFirestore.instance
        .collection(fireStoreCollectionNameUser)
        .doc('rPvne0Q2U7BOMFFBueEc')
        .snapshots();
  }
}
