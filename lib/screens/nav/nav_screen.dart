import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  static const routeName = "/nav";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nav Screen'),
      ),
      body: Text('Nav Screen'),
    );
  }
}
