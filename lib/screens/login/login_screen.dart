import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/blocs/auth/auth_bloc.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/login/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submitForm(BuildContext context, bool isSubmitting) {
    if(_formKey.currentState.validate() && !isSubmitting) {
      context.read<LoginCubit>().loginWithCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.error) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text(state.failure.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Instagram',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12.0),
                              TextFormField(
                                decoration: InputDecoration(hintText: "Email"),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => context
                                    .read<LoginCubit>()
                                    .emailChanged(value),
                                validator: (value) => !value.contains('@')
                                    ? "Please enter a valid Email"
                                    : null,
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Password"),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => context
                                    .read<LoginCubit>()
                                    .passwordChanged(value),
                                validator: (value) => value.length < 6
                                    ? "Must be at least 6 characters long"
                                    : null,
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () => _submitForm(context,
                                    state.status == LoginStatus.submitting),
                                child: Text(
                                  'Login',
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                ),
                              ),
                              // const SizedBox(height: 8.0),
                              TextButton(
                                onPressed: () {
                                  print('Navigate to the signup screen');
                                },
                                child: Text(
                                  'No Account? Sign up!',
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.black54,
                                    backgroundColor: Colors.black12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
