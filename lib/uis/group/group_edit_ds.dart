import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/module/module_select.dart';
import 'package:peat/conectors/worker/worker_select.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/user_model.dart';
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
  final UserModel userRef;

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
    this.userRef,
  }) : super(key: key);
  @override
  _GroupEditDSState createState() => _GroupEditDSState();
}

class _GroupEditDSState extends State<GroupEditDS> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  // final numberTextEditingController =
  //     TextEditingController();

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
    _codigo =
        '${widget.userRef.plataformRef.codigo}.${DateFormat('yyMMdd').format(widget.userRef.dateTimeOnBoard)}.' +
            (widget.number ?? '');
    // numberTextEditingController.text = widget.number;
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

  @override
  void dispose() {
    // numberTextEditingController.dispose();
    super.dispose();
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
        title: Text(
            (widget.isCreateOrUpdate ? 'Criar' : 'Editar') + ' grupo $_codigo'),
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
          bool liberated = true;
          if (liberated) {
            if (widget.moduleRef != null &&
                widget.workerRefMap != null &&
                widget.workerRefMap.isNotEmpty) {
              liberated = true;
            } else {
              liberated = false;
              showSnackBarHandler(
                  context, 'Favor informar Módulo e Trabalhadores.');
            }
          }
          if (liberated) {
            Duration difference = _endCourse.difference(_startCourse);
            if (difference.isNegative) {
              liberated = false;
              showSnackBarHandler(
                  context, 'Data e hora do fim antes do início.');
            } else {
              liberated = true;
            }
          }
          if (liberated) {
            if (_arquived) {
              if (_opened) {
                liberated = false;
                showSnackBarHandler(
                    context, 'Para arquivar deve estar encerrado.');
              } else {
                liberated = true;
              }
            }
          }
          if (liberated) {
            validateData();
          }
        },
      ),
    );
  }

  showSnackBarHandler(context, String msg) {
    scaffoldState.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            // controller: numberTextEditingController,
            initialValue: widget.number,
            decoration: InputDecoration(
              labelText: 'Número do grupo',
            ),
            onChanged: (value) {
              setState(() {
                _codigo =
                    '${widget.userRef.plataformRef.codigo}.${DateFormat('yyMMdd').format(widget.userRef.dateTimeOnBoard)}.$value';
              });
            },
            onSaved: (newValue) {
              _number = newValue;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),

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
                    );
                    // .then((value) => setState(() {}));
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
                              // setState(() {});
                            }),
                      );
                    },
                  ),
                )
              : Container(),
          // TextFormField(
          //   initialValue: widget.codigo,
          //   decoration: InputDecoration(
          //     labelText: 'Código do grupo',
          //   ),
          //   onSaved: (newValue) => _codigo = newValue,
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Informe o que se pede.';
          //     }
          //     return null;
          //   },
          // ),
          // ListTile(
          //   title: Text(_codigo),
          // ),
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
          TextFormField(
            initialValue: widget.description,
            decoration: InputDecoration(
              labelText: 'Descrição do grupo',
            ),
            onSaved: (newValue) => _description = newValue,
          ),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _opened,
                  title: _opened
                      ? Text('Encontro agendado.')
                      : Text('Encontro encerrado.'),
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
                  title: _success
                      ? Text('Sucesso no encontro.')
                      : Text('Problema no encontro.'),
                  onChanged: (value) {
                    setState(() {
                      _success = value;
                    });
                  },
                ),
          widget.isCreateOrUpdate || _opened
              ? Container()
              : SwitchListTile(
                  value: _arquived,
                  title: _arquived ? Text('Arquivar.') : Text('Grupo ativo.'),
                  onChanged: (value) {
                    setState(() {
                      _arquived = value;
                    });
                  },
                ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
