import 'package:flutter/material.dart';
import 'package:flutter_restful/widgets/friend.dart';

class AddPage extends StatelessWidget {
  final Function(Map<String, dynamic>) saveFriend;

  AddPage(this.saveFriend);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Friend'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: FriendWidget(null, saveFriend),
      ),
    );
  }
}
