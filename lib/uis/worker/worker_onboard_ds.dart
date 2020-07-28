import 'package:flutter/material.dart';

class WorkerOnBoardDS extends StatefulWidget {
  final Function(String, bool) onSetWorkerListOnBoard;
  final bool inBoard;

  const WorkerOnBoardDS({Key key, this.onSetWorkerListOnBoard, this.inBoard})
      : super(key: key);

  @override
  _WorkerOnBoardDSState createState() => _WorkerOnBoardDSState();
}

class _WorkerOnBoardDSState extends State<WorkerOnBoardDS> {
  final formKey = GlobalKey<FormState>();
  String _sispats;

  bool _inBoard;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onSetWorkerListOnBoard(_sispats, _inBoard);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _inBoard = widget.inBoard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SISPAT's Check Board"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => validateData(),
        child: Icon(Icons.cloud_upload),
      ),
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          SwitchListTile(
            value: _inBoard,
            title: Text(_inBoard ? 'SISPAT On Board' : 'SISPAT Off Board'),
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
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Informe um SISPATs por linha',
              border: OutlineInputBorder(),
            ),
            onSaved: (newValue) => _sispats = newValue,
          ),
        ],
      ),
    );
  }
}
