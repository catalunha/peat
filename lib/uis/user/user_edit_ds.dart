import 'package:flutter/material.dart';

class UserEditDS extends StatefulWidget {
  final String email;
  final String displayName;
  final String sispat;
  final Function(String, String) onUpdate;

  const UserEditDS({
    this.email,
    Key key,
    this.displayName,
    this.sispat,
    this.onUpdate,
  }) : super(key: key);
  @override
  _UserEditDSState createState() => _UserEditDSState();
}

class _UserEditDSState extends State<UserEditDS> {
  final formKey = GlobalKey<FormState>();
  String displayName;
  String sispat;

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onUpdate(displayName, sispat);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Atualizar Usuário'),
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
          ListTile(
            title: Text('Email:${widget.email}'),
          ),
          TextFormField(
            initialValue: widget.displayName,
            decoration: InputDecoration(
              labelText: 'Nome completo:',
            ),
            onSaved: (value) => displayName = value,
          ),
          TextFormField(
            initialValue: widget.sispat,
            decoration: InputDecoration(
              labelText: 'SISPAT:',
            ),
            onSaved: (value) => sispat = value,
          ),
          ListTile(
            title: Center(child: Text('Atualizar')),
            onTap: () {
              validateData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
