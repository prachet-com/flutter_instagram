import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/login/cubit/login_cubit.dart';

class NavScreen extends StatelessWidget {
  static const routeName = "/nav";

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener}
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nav Screen'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // context.read<AuthRepository>();
                context.read<LoginCubit>().logout();
              },
              child: Text(
                'Logout',
              ),
              style: ElevatedButton.styleFrom(
                elevation: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
