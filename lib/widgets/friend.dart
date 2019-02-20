import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FriendWidget extends StatefulWidget {
  final Map<String, dynamic> friend;
  final Function(Map<String, dynamic>) saveFriend;

  FriendWidget(this.friend, this.saveFriend);

  @override
  State<StatefulWidget> createState() {
    return FriendWidgetState();
  }
}

class FriendWidgetState extends State<FriendWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _age = TextEditingController();

  @override
  void initState() {
    if (widget.friend != null) {
      _firstName.text = widget.friend['first_name'];
      _lastName.text = widget.friend['last_name'];
      _age.text = widget.friend['age'].toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _firstName,
            decoration: InputDecoration(labelText: 'First name'),
            autofocus: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input first name!';
              }
            },
          ),
          TextFormField(
            controller: _lastName,
            decoration: InputDecoration(labelText: 'Last name'),
          ),
          TextFormField(
            controller: _age,
            inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9]'))],
            decoration: InputDecoration(labelText: 'Age'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please input age!';
              }
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: OutlineButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      final Map<String, dynamic> data = {
                        'first_name': _firstName.text,
                        'last_name': _lastName.text,
                        'age': int.parse(_age.text)
                      };

                      widget.saveFriend(data);

                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
