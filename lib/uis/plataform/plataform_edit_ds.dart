import 'package:flutter/material.dart';

class PlataformEditDS extends StatefulWidget {
  final String codigo;
  final String description;
  final bool arquived;
  final bool isCreateOrUpdate;
  final Function(String, String) onCreate;
  final Function(String, String, bool) onUpdate;

  const PlataformEditDS({
    Key key,
    this.codigo,
    this.description,
    this.arquived,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _PlataformEditDSState createState() => _PlataformEditDSState();
}

class _PlataformEditDSState extends State<PlataformEditDS> {
  final formKey = GlobalKey<FormState>();
  String _codigo;
  String _description;
  bool _arquived;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_codigo, _description)
          : widget.onUpdate(_codigo, _description, _arquived);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _arquived = widget.arquived;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isCreateOrUpdate ? 'Criar plataforma' : 'Editar plataforma'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          validateData();
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            initialValue: widget.codigo,
            decoration: InputDecoration(
              labelText: 'Codigo da plataforma',
            ),
            onSaved: (newValue) => _codigo = newValue,
          ),
          TextFormField(
            initialValue: widget.description,
            decoration: InputDecoration(
              labelText: 'Descrição da plataforma',
            ),
            onSaved: (newValue) => _description = newValue,
          ),
          SwitchListTile(
            value: _arquived,
            title: Text('Arquivar esta plataforma'),
            onChanged: (value) {
              setState(() {
                _arquived = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
