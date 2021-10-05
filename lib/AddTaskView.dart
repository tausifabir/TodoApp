import 'package:flutter/material.dart';

class AddTaskView extends StatefulWidget {
  final String text;
  AddTaskView({required this.text});
  @override
  _State createState() => _State();
}

class _State extends State<AddTaskView> {
  late TextEditingController myTextController;

  @override
  void initState() {
    // TODO: implement initState
    myTextController = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              key: Key("createTask"),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Create Task',
                hintText: 'task',
              ),
              controller: myTextController,
              onEditingComplete: () => save(),
            ),
            TextButton(
              key: Key("saveBtn"),
                onPressed: () => save(),
                child: Text(
                  "Save",
                  style: TextStyle(color: Theme.of(context).accentColor),
                )),
          ],
        ),
      ),
    );
  }

  void save() {
    if (myTextController.text.isNotEmpty)
      Navigator.of(context).pop(myTextController.text);
  }
}
