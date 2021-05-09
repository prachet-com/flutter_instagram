import 'package:bloc/bloc.dart';
import 'package:flutter_instagram/models/failure_model.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part './login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void loginWithCredentials() async {
    if(!state.isFormValid || state.status == LoginStatus.submitting) {
      return;
    }
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.loginWithUsernameAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success, failure: Failure()));
    } on Failure catch (err) {
      emit(state.copyWith(status: LoginStatus.error, failure: err));
    }
  }

  void loginWithGoogle () async {
    await _authRepository.googleSignIn();
  }

  void signInAnonymously () async {
    await _authRepository.signInAnonymously();
  }

  void logout() async {
    await _authRepository.logout();
  }
}
