import 'package:flutter/material.dart';
import 'package:flutter_restful/widgets/friend.dart';

class EditPage extends StatelessWidget {
  final Map<String, dynamic> friend;
  final Function(Map<String, dynamic>) saveFriend;

  EditPage(this.friend, this.saveFriend);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Friend'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: FriendWidget(friend, saveFriend),
      ),
    );
  }
}
