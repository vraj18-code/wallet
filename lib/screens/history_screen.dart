import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: Center(
        child: Text("This is the history page."),
        // Implement history list or logs as needed
      ),
    );
  }
}
