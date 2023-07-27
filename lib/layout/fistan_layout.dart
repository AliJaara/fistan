import 'package:flutter/material.dart';

class FistanLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fistan"),
        leading: Text("Fistan Lead"),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app))],
      ),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
