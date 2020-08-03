import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/module/module_select.dart';
import 'package:peat/conectors/worker/worker_select.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/worker_model.dart';

class GroupEditDS extends StatefulWidget {
  final String codigo;
  final String number;
  final String description;
  final dynamic startCourse;
  final dynamic endCourse;
  final String localCourse;
  final String urlFolder;
  final String urlPhoto;
  final ModuleModel moduleRef;

  final Map<String, WorkerModel> workerRefMap;

  final bool opened;
  final bool success;
  final bool arquived;
  final bool isCreateOrUpdate;
  final Function(
          String, String, String, dynamic, dynamic, String, String, String)
      onCreate;
  final Function(String, String, String, dynamic, dynamic, String, String,
      String, bool, bool, bool) onUpdate;
  final Function() onEditPop;
  final Function(WorkerModel, bool) onSetWorkerTheGroupSyncGroupAction;
  final List<WorkerModel> workerList;

  const GroupEditDS({
    Key key,
    this.codigo,
    this.description,
    this.arquived,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.urlFolder,
    this.urlPhoto,
    this.number,
    this.startCourse,
    this.endCourse,
    this.localCourse,
    this.opened,
    this.success,
    this.moduleRef,
    this.workerRefMap,
    this.onEditPop,
    this.onSetWorkerTheGroupSyncGroupAction,
    this.workerList,
  }) : super(key: key);
  @override
  _GroupEditDSState createState() => _GroupEditDSState();
}

class _GroupEditDSState extends State<GroupEditDS> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  String _codigo;
  String _number;
  String _description;
  DateTime _startCourse;
  TimeOfDay _startCourseTime;
  DateTime _endCourse;
  TimeOfDay _endCourseTime;
  String _localCourse;
  String _urlFolder;
  String _urlPhoto;
  bool _opened;
  bool _success;
  bool _arquived;
  @override
  void initState() {
    super.initState();
    _opened = widget.opened;
    _success = widget.success;
    _arquived = widget.arquived;
    _startCourse =
        widget.startCourse != null ? widget.startCourse : DateTime.now();
    _startCourseTime = widget.startCourse != null
        ? TimeOfDay.fromDateTime(widget.startCourse)
        : TimeOfDay.now();

    _endCourse = widget.endCourse != null ? widget.endCourse : DateTime.now();
    _endCourseTime = widget.startCourse != null
        ? TimeOfDay.fromDateTime(widget.endCourse)
        : TimeOfDay.now();
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      widget.isCreateOrUpdate
          ? widget.onCreate(
              _codigo,
              _number,
              _description,
              _startCourse,
              _endCourse,
              _localCourse,
              _urlFolder,
              _urlPhoto,
            )
          : widget.onUpdate(
              _codigo,
              _number,
              _description,
              _startCourse,
              _endCourse,
              _localCourse,
              _urlFolder,
              _urlPhoto,
              _opened,
              _success,
              _arquived,
            );
    } else {
      setState(() {});
    }
  }

  Future<void> onStartCourseDate(context) async {
    final DateTime showDatePickerStart = await showDatePicker(
      context: context,
      initialDate: _startCourse,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      helpText: 'Data de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
    );
    if (showDatePickerStart != null && showDatePickerStart != _startCourse) {
      setState(() {
        _startCourse = showDatePickerStart;
      });
    }
  }

  Future<void> onStartCourseTime(context) async {
    TimeOfDay showTimePickerStart = await showTimePicker(
      initialTime: _startCourseTime,
      context: context,
      helpText: 'Horário de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (showTimePickerStart != null) {
      setState(() {
        _startCourseTime = showTimePickerStart;
      });
    }
  }

  Future<void> onEndCourseDate(context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _endCourse,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      helpText: 'Data de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
    );
    if (picked != null && picked != _endCourse) {
      setState(() {
        _endCourse = picked;
      });
    }
  }

  Future<void> onEndCourseTime(context) async {
    TimeOfDay showTimePickerEnd = await showTimePicker(
      initialTime: _endCourseTime,
      context: context,
      helpText: 'Horário de inicio',
      confirmText: 'Ok',
      cancelText: 'Cancelar',
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (showTimePickerEnd != null) {
      setState(() {
        _endCourseTime = showTimePickerEnd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text(widget.isCreateOrUpdate ? 'Criar grupo' : 'Editar grupo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => widget.onEditPop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          if (widget.moduleRef != null &&
              widget.workerRefMap != null &&
              widget.workerRefMap.isNotEmpty) {
            validateData();
          } else {
            showSnackBarHandler(context);
          }
        },
      ),
    );
  }

  showSnackBarHandler(context) {
    scaffoldState.currentState.showSnackBar(
        SnackBar(content: Text('Favor informar Módulo e Trabalhadores.')));
  }

  _workerIdData(String workerId) {
    String _return = workerId;
    if (workerId != null &&
        widget.workerList != null &&
        widget.workerList.isNotEmpty) {
      print('workerId: $workerId ... widget.workerList.: ${widget.workerList}');
      WorkerModel workerModel =
          widget.workerList.firstWhere((element) => element.id == workerId);
      _return =
          '${workerModel.id.substring(0, 5)},${workerModel.sispat}, ${workerModel.displayName}, ${workerModel.company}, ${workerModel.activity}. ';
    }
    return _return;
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          ListTile(
            title: Text('${widget.moduleRef?.codigo}'),
            subtitle: Text('Qual modulo para este grupo'),
            trailing: Icon(Icons.search),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ModuleSelect(),
              );
            },
          ),
          widget.moduleRef != null
              ? ListTile(
                  title: Text(
                      'Há ${widget.workerRefMap != null && widget.workerRefMap.isNotEmpty ? widget.workerRefMap.length : null} trabalhador(es) neste grupo'),
                  trailing: Icon(Icons.search),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => WorkerSelect(),
                    ).then((value) => setState(() {}));
                  },
                )
              : Container(),
          widget.workerRefMap != null && widget.workerRefMap.isNotEmpty
              ? Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.workerRefMap.length,
                    itemBuilder: (context, index) {
                      WorkerModel workerRef =
                          widget.workerRefMap.entries.toList()[index].value;
                      return ListTile(
                        title: Text('${workerRef}'),
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              widget.onSetWorkerTheGroupSyncGroupAction(
                                workerRef,
                                false,
                              );
                              setState(() {});
                            }),
                      );
                    },
                  ),
                )
              : Container(),
          TextFormField(
            initialValue: widget.codigo,
            decoration: InputDecoration(
              labelText: 'Código do grupo',
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
            initialValue: widget.number,
            decoration: InputDecoration(
              labelText: 'Número do grupo',
            ),
            onSaved: (newValue) => _number = newValue,
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
              labelText: 'Descrição do grupo',
            ),
            onSaved: (newValue) => _description = newValue,
          ),
          TextFormField(
            initialValue: widget.localCourse,
            decoration: InputDecoration(
              labelText: 'Local do encontro',
            ),
            onSaved: (newValue) => _localCourse = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          ListTile(
            title:
                Text('${DateFormat('yyyy-MM-dd HH:mm').format(_startCourse)}'),
            subtitle: Text('Inicio do encontro'),
            trailing: Icon(Icons.date_range),
            onTap: () {
              onStartCourseDate(context)
                  .then((value) => onStartCourseTime(context).then((value) {
                        _startCourse = DateTime(
                          _startCourse.year,
                          _startCourse.month,
                          _startCourse.day,
                          _startCourseTime.hour,
                          _startCourseTime.minute,
                        );
                      }));
            },
          ),
          ListTile(
            title: Text('${DateFormat('yyyy-MM-dd HH:mm').format(_endCourse)}'),
            subtitle: Text('Fim do encontro'),
            trailing: Icon(Icons.date_range),
            onTap: () {
              onEndCourseDate(context)
                  .then((value) => onEndCourseTime(context).then((value) {
                        _endCourse = DateTime(
                          _endCourse.year,
                          _endCourse.month,
                          _endCourse.day,
                          _endCourseTime.hour,
                          _endCourseTime.minute,
                        );
                      }));
            },
          ),
          TextFormField(
            initialValue: widget.urlFolder,
            decoration: InputDecoration(
              labelText: 'Link da pasta de relatorios do encontro',
            ),
            onSaved: (newValue) => _urlFolder = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.urlPhoto,
            decoration: InputDecoration(
              labelText: 'Link da foto do grupo no encontro',
            ),
            onSaved: (newValue) => _urlPhoto = newValue,
          ),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _opened,
                  title: Text('Grupo aberto ?'),
                  onChanged: (value) {
                    setState(() {
                      _opened = value;
                    });
                  },
                ),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _success,
                  title: Text('Sucesso no encontro ?'),
                  onChanged: (value) {
                    setState(() {
                      _success = value;
                    });
                  },
                ),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _arquived,
                  title: Text('Arquivar grupo ?'),
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
