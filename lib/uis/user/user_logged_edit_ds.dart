import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/plataform/plataform_onboard.dart';

class UserLoggedEditDS extends StatefulWidget {
  final String email;
  final String displayName;
  final String sispat;
  final String plataformOnBoard;
  final dynamic dateTimeOnBoard;

  final Function(dynamic) onUpdate;

  const UserLoggedEditDS({
    this.email,
    Key key,
    this.displayName,
    this.sispat,
    this.onUpdate,
    this.plataformOnBoard,
    this.dateTimeOnBoard,
  }) : super(key: key);
  @override
  _UserLoggedEditDSState createState() => _UserLoggedEditDSState();
}

class _UserLoggedEditDSState extends State<UserLoggedEditDS> {
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
      widget.onUpdate(selectedDate);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar dados do usuário'),
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
            subtitle: Text('Data do embarque na plataforma'),
            trailing: Icon(Icons.date_range),
            onTap: () {
              _selectDate(context);
            },
          ),
          ListTile(
            title: Text('${widget.displayName}'),
            subtitle: Text('Nome completo'),
          ),
          ListTile(
            title: Text('${widget.sispat}'),
            subtitle: Text('SISPAT'),
          ),
          ListTile(
            title: Text('${widget.email}'),
            subtitle: Text('Email'),
          ),
        ],
      ),
    );
  }
}
