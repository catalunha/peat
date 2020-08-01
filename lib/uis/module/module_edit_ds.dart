import 'package:flutter/material.dart';

class ModuleEditDS extends StatefulWidget {
  final String codigo;
  final String description;
  final String urlFolder;
  final bool arquived;
  final bool isCreateOrUpdate;
  final Function(String, String, String) onCreate;
  final Function(String, String, String, bool) onUpdate;

  const ModuleEditDS({
    Key key,
    this.codigo,
    this.description,
    this.arquived,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.urlFolder,
  }) : super(key: key);
  @override
  _ModuleEditDSState createState() => _ModuleEditDSState();
}

class _ModuleEditDSState extends State<ModuleEditDS> {
  final formKey = GlobalKey<FormState>();
  String _codigo;
  String _description;
  String _urlFolder;
  bool _arquived;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_codigo, _description, _urlFolder)
          : widget.onUpdate(_codigo, _description, _urlFolder, _arquived);
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
        title: Text(widget.isCreateOrUpdate ? 'Criar modulo' : 'Editar modulo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
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

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            initialValue: widget.codigo,
            decoration: InputDecoration(
              labelText: 'Codigo do modulo',
            ),
            onSaved: (newValue) => _codigo = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.description,
            decoration: InputDecoration(
              labelText: 'Descrição do modulo',
            ),
            onSaved: (newValue) => _description = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.urlFolder,
            decoration: InputDecoration(
              labelText: 'Folder do modulo',
            ),
            onSaved: (newValue) => _urlFolder = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _arquived,
                  title: Text('Arquivar modulo'),
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
