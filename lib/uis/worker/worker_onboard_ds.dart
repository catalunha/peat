import 'package:flutter/material.dart';

class WorkerOnBoardDS extends StatefulWidget {
  final Function(String, bool) onSetWorkerListOnBoard;
  final bool inBoard;
  final bool waiting;
  final String workerMsg;

  const WorkerOnBoardDS(
      {Key key,
      this.onSetWorkerListOnBoard,
      this.inBoard,
      this.workerMsg,
      this.waiting})
      : super(key: key);

  @override
  _WorkerOnBoardDSState createState() => _WorkerOnBoardDSState();
}

class _WorkerOnBoardDSState extends State<WorkerOnBoardDS> {
  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();
  String _sispats;
  bool _inBoard;

  @override
  void initState() {
    super.initState();
    _inBoard = widget.inBoard;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onSetWorkerListOnBoard(_sispats, _inBoard);
      textEditingController.text = '';
      setState(() {});
      // showAlertDialog(context);
    } else {
      setState(() {});
    }
  }

  // showAlertDialog(BuildContext context) {
  //   // configura o button
  //   Widget okButton = FlatButton(
  //     child: Text("OK"),
  //     onPressed: () {
  //       textEditingController.text = widget.workerMsg;
  //       Navigator.pop(context);
  //     },
  //   );
  //   // configura o  AlertDialog
  //   AlertDialog alerta = AlertDialog(
  //     title: Text("Aviso."),
  //     content: Text(
  //         'Se alguns SISPATs não foram encontrados eles retornaram pra lista para revisão.'),
  //     actions: [
  //       okButton,
  //     ],
  //   );
  //   // exibe o dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alerta;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.workerMsg.isNotEmpty) {
      textEditingController.text = widget.workerMsg;
    }
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("on/off BOARD SISPAT"),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: form(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => validateData(),
            child: Icon(Icons.cloud_upload),
          ),
        ),
        if (widget.waiting)
          Material(
            child: Stack(
              children: [
                Center(child: CircularProgressIndicator()),
                Center(
                  child: Text(
                    'Processando...',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ModalBarrier(
                  color: Colors.green.withOpacity(0.4),
                ),
              ],
            ),
          )
        // CircularProgressIndicator(),
      ],
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          SwitchListTile(
            value: _inBoard,
            title: Text(_inBoard ? 'ON  BOARD SISPAT' : 'OFF BOARD SISPAT'),
            secondary: _inBoard
                ? Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
            onChanged: (value) {
              setState(() {
                _inBoard = value;
              });
            },
          ),
          TextFormField(
            controller: textEditingController,
            // initialValue: textEditingController.text,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Informe um SISPAT por linha',
              border: OutlineInputBorder(),
            ),
            onSaved: (newValue) => _sispats = newValue,
          ),
          Text(
            'Se alguns SISPATs não forem encontrados eles retornaram pra lista para revisão.',
          ),
        ],
      ),
    );
  }
}
