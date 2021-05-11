import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  static const routeName = "/feed";

  const FeedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Add page'),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(title: Text('New page'),),
              )
            )
          ),
        ),
      ),
    );
  }
}
