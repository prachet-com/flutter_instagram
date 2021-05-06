import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                          onChanged: (value) => print(value),
                          validator: (value) => !value.contains('@')
                              ? "Please enter a valid Email"
                              : null,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Password"),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => print(value),
                          validator: (value) => value.length < 6
                              ? "Must be at least 6 characters long"
                              : null,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            print('Log in');
                          },
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
                            backgroundColor: Colors.black12
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
