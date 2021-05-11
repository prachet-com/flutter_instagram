import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileImageUrl;
  final int followers;
  final int following;
  final String bio;

  const UserModel({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.profileImageUrl,
    @required this.followers,
    @required this.following,
    @required this.bio,
  });

  static const empty = UserModel(
    id: '',
    username: '',
    email: '',
    profileImageUrl: '',
    followers: 0,
    following: 0,
    bio: '',
  );

  @override
  List<Object> get props =>
      [id, username, email, profileImageUrl, followers, following, bio];

  UserModel copyWith({
    String id,
    String username,
    String email,
    String profileImageUrl,
    int followers,
    int following,
    String bio,
  }) {
    return new UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "username": username,
      "email": email,
      "profileImageUrl": profileImageUrl,
      "followers": followers,
      "following": following,
      "bio": bio
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot<UserModel> docSnapshot) {
    if (docSnapshot == null) {
      return null;
    }
    final data = docSnapshot.data();
    return UserModel(
      id: docSnapshot.id ?? '',
      username: data.username ?? '',
      email: data.email ?? '',
      profileImageUrl: data.profileImageUrl ?? '',
      followers: (data.followers ?? 0).toInt(),
      following: (data.following ?? 0).toInt(),
      bio: data.bio ?? '',
    );
  }
}
