import 'package:flutter/material.dart';
import 'package:peat/conectors/components/logout_button.dart';

class HomePageDS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PEAT'),
        actions: [LogoutButton()],
      ),
    );
  }
}
