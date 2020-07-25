import 'package:flutter/material.dart';

class UserEditDS extends StatefulWidget {
  final String displayName;
  final String sispat;
  final Function(String, String) onUpdate;

  const UserEditDS({
    Key key,
    this.displayName,
    this.sispat,
    this.onUpdate,
  }) : super(key: key);
  @override
  _UserEditDSState createState() => _UserEditDSState();
}

class _UserEditDSState extends State<UserEditDS> {
  static final formKey = GlobalKey<FormState>();
  String displayName;
  String sispat;

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onUpdate(displayName, sispat);
      Navigator.pop(context);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update User'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: form(),
        ));
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            initialValue: widget.displayName,
            decoration: InputDecoration(
              labelText: 'UserName:',
            ),
            onSaved: (value) => displayName = value,
          ),
          TextFormField(
            initialValue: widget.sispat,
            decoration: InputDecoration(
              labelText: 'sispat:',
            ),
            onSaved: (value) => sispat = value,
          ),
          ListTile(
            title: Center(child: Text('Atualizar')),
            onTap: () {
              Navigator.pop(context);
              validateData();
            },
          ),
        ],
      ),
    );
  }
}
