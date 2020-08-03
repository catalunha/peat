import 'package:flutter/material.dart';
import 'package:peat/models/module_model.dart';

class WorkerEditDS extends StatefulWidget {
  final String sispat;
  final String displayName;
  final String activity;
  final String company;
  final bool arquived;
  final Map<String, ModuleModel> moduleRefMap;
  final bool isCreateOrUpdate;

  final Function(String, String, String, String) onCreate;
  final Function(String, String, String, String, bool) onUpdate;
  final Function(String) onRemoveModuleSyncWorkerAction;

  const WorkerEditDS({
    Key key,
    this.arquived,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.sispat,
    this.displayName,
    this.activity,
    this.company,
    this.moduleRefMap,
    this.onRemoveModuleSyncWorkerAction,
  }) : super(key: key);
  @override
  _WorkerEditDSState createState() => _WorkerEditDSState();
}

class _WorkerEditDSState extends State<WorkerEditDS> {
  final formKey = GlobalKey<FormState>();
  String _sispat;
  String _displayName;
  String _activity;
  String _company;
  bool _arquived;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(
              _sispat,
              _displayName,
              _activity,
              _company,
            )
          : widget.onUpdate(
              _sispat, _displayName, _activity, _company, _arquived);
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
        title: Text(widget.isCreateOrUpdate
            ? 'Cadastrar trabalhador'
            : 'Editar trabalhador'),
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
            initialValue: widget.sispat,
            decoration: InputDecoration(
              labelText: 'SISPAT',
            ),
            onSaved: (newValue) => _sispat = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.displayName,
            decoration: InputDecoration(
              labelText: 'Nome',
            ),
            onSaved: (newValue) => _displayName = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.company,
            decoration: InputDecoration(
              labelText: 'Empresa',
            ),
            onSaved: (newValue) => _company = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.activity,
            decoration: InputDecoration(
              labelText: 'Função na empresa',
            ),
            onSaved: (newValue) => _activity = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          widget.moduleRefMap != null && widget.moduleRefMap.isNotEmpty
              ? ListTile(
                  title: Text(
                      'Há ${widget.moduleRefMap?.length} modulo(s) concluídos.'),
                )
              : Container(),
          widget.moduleRefMap != null && widget.moduleRefMap.isNotEmpty
              ? Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.moduleRefMap.length,
                    itemBuilder: (context, index) {
                      ModuleModel moduleRef =
                          widget.moduleRefMap.entries.toList()[index].value;
                      return ListTile(
                        title: Text('${moduleRef.codigo} || $moduleRef'),
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              widget.onRemoveModuleSyncWorkerAction(
                                moduleRef.id,
                              );
                              setState(() {});
                            }),
                      );
                    },
                  ),
                )
              : Container(),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _arquived,
                  title: Text('Arquivar trabalhador'),
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
