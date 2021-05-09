import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_instagram/blocs/auth/auth_bloc.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import './cubit/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = "/signup";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<SignupCubit>().signupWithCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider<SignupCubit>(
        create: (context) => SignupCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state.status == SignupStatus.error) {
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
                                decoration: InputDecoration(
                                  hintText: "Username",
                                ),
                                keyboardType: TextInputType.text,
                                onChanged: (value) => context
                                    .read<SignupCubit>()
                                    .usernameChanged(value),
                                // validator: (value) => value.length < 6
                                //     ? "Username should be at least 6 "
                                //         "character long"
                                //     : null,
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration: InputDecoration(hintText: "Email"),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => context
                                    .read<SignupCubit>()
                                    .emailChanged(value),
                                validator: (value) => !value.contains('@')
                                    ? "Please enter a valid Email"
                                    : null,
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Password"),
                                obscureText: true,
                                onChanged: (value) => context
                                    .read<SignupCubit>()
                                    .passwordChanged(value),
                                validator: (value) => value.length < 6
                                    ? "Must be at least 6 characters long"
                                    : null,
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () => _submitForm(context,
                                    state.status == SignupStatus.submitting),
                                child: Text(
                                  'Sign up',
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                ),
                              ),
                              // const SizedBox(height: 8.0),
                              TextButton(
                                onPressed: () {
                                  print('Back to Login');
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Back to Login',
                                ),
                                style: TextButton.styleFrom(
                                  primary: Colors.black54,
                                  backgroundColor: Colors.black12,
                                ),
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
