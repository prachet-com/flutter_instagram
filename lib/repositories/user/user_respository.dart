import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/config/Paths.dart';
import 'package:flutter_instagram/models/user_model.dart';
import 'package:flutter_instagram/repositories/user/base_user_repository.dart';
import 'package:meta/meta.dart';

class UserRepository extends BaseUserRepository {
  FirebaseFirestore _firebaseFirestore;

  UserRepository({
    @required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<UserModel> getUserWithId({@required String userId}) async {
    final doc = await _firebaseFirestore
        .collection(Paths.users)
        .doc(userId)
        .get() as DocumentSnapshot<UserModel>;

    return doc.exists ? UserModel.fromDocument(doc) : null;
    // return doc.exists ? UserModel.fromDocument(doc) : UserModel.empty;
  }

  @override
  Future<void> updateUser({@required UserModel user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toDocument());
  }

  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot<UserModel> querySnapshot = await _firebaseFirestore
        .collection(Paths.users)
        .get() as QuerySnapshot<UserModel>;
    return UserModel.getUserListFromQuerySnapshot(querySnapshot);
  }

  Future<void> deleteUser(String userId) async {
    await _firebaseFirestore.collection(Paths.users).doc(userId).delete();
  }
}
