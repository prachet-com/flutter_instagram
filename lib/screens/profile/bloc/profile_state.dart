part of 'profile_bloc.dart';

enum PostsView { list, grid }

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final UserModel user;

  // final List<Posts> posts;
  final bool isCurrentUser;
  final bool isFollowing;
  final PostsView postsView;
  final ProfileStatus loadingStatus;
  final Failure failure;

  const ProfileState({
    @required this.user,
    @required this.isCurrentUser,
    @required this.postsView,
    @required this.isFollowing,
    @required this.loadingStatus,
    @required this.failure,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      user: UserModel.empty,
      isCurrentUser: false,
      postsView: PostsView.grid,
      isFollowing: false,
      loadingStatus: ProfileStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props => [
        user,
        isCurrentUser,
        postsView,
        isFollowing,
        loadingStatus,
        failure,
      ];

  ProfileState copyWith({
    UserModel user,
    bool isCurrentUser,
    bool isFollowing,
    PostsView postsView,
    ProfileStatus loadingStatus,
    Failure failure,
  }) {
    return new ProfileState(
      user: user ?? this.user,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
      isFollowing: isFollowing ?? this.isFollowing,
      postsView: postsView ?? this.postsView,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      failure: failure ?? this.failure,
    );
  }
}
