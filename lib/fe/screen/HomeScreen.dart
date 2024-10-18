import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: PopupMenuButton(
            child: const Text('Select Screen'),
            onSelected: (String result) {
              Navigator.pushNamed(context, result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '/screen1',
                child: Text('Screen 1'),
              ),
              const PopupMenuItem<String>(
                value: '/screen2',
                child: Text('Screen 2'),
              ),
            ]
        )
      ),
    );
  }
}