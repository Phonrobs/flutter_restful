import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_restful/pages/edit.dart';
import 'package:flutter_restful/pages/add.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _friends = List<Map<String, dynamic>>();
  int _currentFriend;

  void _loadFriends() {
    http
        .get('https://mytestapp-2d376.firebaseio.com/friends.json')
        .then((response) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        data.forEach((id, item) {
          item['id'] = id;
          _friends.add(item);
        });
      });
    });
  }

  void _saveFriend(Map<String, dynamic> friend) {
    String jsonData = json.encode(friend);

    if (_currentFriend == null) {
      http
          .post('https://mytestapp-2d376.firebaseio.com/friends.json',
              body: jsonData)
          .then((response) {
            Map<String,dynamic> responseData = json.decode(response.body);
        setState(() {
          friend['id'] = responseData['name'];
          _friends.add(friend);
        });
      });
    } else {
      http
          .put(
              'https://mytestapp-2d376.firebaseio.com/friends/${_friends[_currentFriend]['id']}.json',
              body: jsonData)
          .then((response) {
        setState(() {
          _friends[_currentFriend] = friend;
        });

        _currentFriend = null;
      });
    }
  }

  void _deleteFriend(int index) {
    http
        .delete(
            'https://mytestapp-2d376.firebaseio.com/friends/${_friends[index]['id']}.json')
        .then((response) {
      setState(() {
        _friends.removeAt(index);
      });
    });
  }

  @override
  void initState() {
    _loadFriends();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.0),
        itemCount: _friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${_friends[index]['first_name']} ${_friends[index]['last_name']}'),
            leading: Icon(Icons.person),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                _deleteFriend(index);
              },
            ),
            onTap: () {
              _currentFriend = index;

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditPage(_friends[_currentFriend], _saveFriend);
              }));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddPage(_saveFriend);
          }));
        },
      ),
    );
  }
}
