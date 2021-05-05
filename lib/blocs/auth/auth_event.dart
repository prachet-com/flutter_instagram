part of 'auth_bloc.dart';

//contains all the events that we can send to our bloc

@immutable
abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final auth.User user;

  const AuthUserChanged({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLogoutRequested extends AuthEvent{}
