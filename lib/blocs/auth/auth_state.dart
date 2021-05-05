part of 'auth_bloc.dart';

//state of the bloc

enum AuthStatus { unknown, authenticated, unauthenticated }

@immutable
class AuthState extends Equatable {
  final auth.User user;
  final AuthStatus status;

  AuthState({this.user, this.status = AuthStatus.unknown});

  @override
  List<Object> get props => [user, status];

  @override
  bool get stringify => true;

  factory AuthState.unknown() => AuthState();

  factory AuthState.authenticated({@required auth.User user}) {
    return AuthState(user: user, status: AuthStatus.authenticated);
  }

  factory AuthState.unauthenticated() =>
      AuthState(status: AuthStatus.unauthenticated);
}

//class AuthInitial extends AuthState {}
