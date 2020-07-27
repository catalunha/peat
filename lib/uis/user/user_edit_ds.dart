import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/plataform/plataform_onboard.dart';

class UserEditDS extends StatefulWidget {
  final String email;
  final String displayName;
  final String sispat;
  final String plataformOnBoard;
  final dynamic dateTimeOnBoard;

  final Function(String, String, dynamic) onUpdate;

  const UserEditDS({
    this.email,
    Key key,
    this.displayName,
    this.sispat,
    this.onUpdate,
    this.plataformOnBoard,
    this.dateTimeOnBoard,
  }) : super(key: key);
  @override
  _UserEditDSState createState() => _UserEditDSState();
}

class _UserEditDSState extends State<UserEditDS> {
  final formKey = GlobalKey<FormState>();
  String displayName;
  String sispat;
  DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    selectedDate = widget.dateTimeOnBoard != null
        ? widget.dateTimeOnBoard
        : DateTime.now();
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onUpdate(displayName, sispat, selectedDate);
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
        padding: EdgeInsets.all(2.0),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          validateData();
        },
      ),
    );
  }

  _selectDate(context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('${widget.plataformOnBoard}'),
            subtitle: Text('Embarcado na Plataforma'),
            trailing: Icon(Icons.search),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => PlataformOnBoard(),
              );
            },
          ),
          ListTile(
            title: Text('${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
            subtitle: Text('Embarcado em'),
            trailing: Icon(Icons.date_range),
            onTap: () {
              _selectDate(context);
            },
          ),

          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: TextFormField(
              initialValue: widget.displayName,
              decoration: InputDecoration(
                labelText: 'Nome completo:',
              ),
              onSaved: (value) => displayName = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: TextFormField(
              initialValue: widget.sispat,
              decoration: InputDecoration(
                labelText: 'SISPAT:',
              ),
              onSaved: (value) => sispat = value,
            ),
          ),
          ListTile(
            title: Text('${widget.email}'),
            subtitle: Text('Email'),
          ),
          // ListTile(
          //   title: Center(child: Text('Atualizar')),
          //   onTap: () {
          //     validateData();
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}
