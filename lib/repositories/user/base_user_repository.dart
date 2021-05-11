import 'package:flutter_instagram/models/user_model.dart';

abstract class BaseUserRepository {
  Future<UserModel> getUserWithId({String userId});
  Future<void> updateUser({UserModel user});
}
