import 'package:flutter/material.dart';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/CompeletedTask.dart';
import 'package:todo_app/TaskModel.dart';
import 'AddTaskView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      /*home: ChangeNotifierProvider<TodoModel>(
        create: (context) => TodoModel(),
        child: MyHomePage(),
      ),*/

      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  List<TaskModel> taskList = [];
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState

    initializeSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Application"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CompletedTask();
                }));
              },
            ),
          )
        ],
      ),
      body: taskList.isNotEmpty ? buildBody() : buildNotBody(),
      floatingActionButton: FloatingActionButton(
        key: Key("floatingBtn"),
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () => addToTasks(),
      ),
    );
  }

  Widget buildBody() {
    return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return buildItem(taskList[index]);
        });
  }

  Widget buildNotBody() {
    return Center(
      child: Text("No Item"),
    );
  }

  Widget buildItem(TaskModel item) {
    return Dismissible(
      key: Key(item.hashCode.toString()),
      onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.purple,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12.0),
      ),
      child: ListTile(
        title: Text(item.title),
        trailing: Checkbox(
          key: Key("checkBox"),
          value: item.complete,
          onChanged: (val){},
          activeColor: Colors.purple,
        ),
        onTap: () => setCompleteness(item),
        onLongPress: () => editItem(item),
      ),
    );
  }

  void addToTasks() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddTaskView(
        text: '',
      );
    })).then((title) {
      if (title != null) {
        addToNewTask(TaskModel(title: title));
      }
    });
  }

  void setCompleteness(TaskModel item) {
    setState(() {
      item.complete = !item.complete;
    });
    saveSharedPreferences();
  }

  void removeItem(TaskModel item) {
    taskList.remove(item);
    saveSharedPreferences();
    if (taskList.isEmpty) {
      setState(() {});
    }
  }

  void addToNewTask(TaskModel item) {
    taskList.add(item);
    saveSharedPreferences();
    setState(() {});
  }

  editItem(TaskModel item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddTaskView(
        text: item.title,
      );
    })).then((title) {
      if (title != null) {
        editTaskItem(item, title);
      }
    });
  }

  void editTaskItem(TaskModel item, title) {
    item.title = title;
    saveSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadSharedPreferences();
  }

  void saveSharedPreferences() {
    List<String> sharedList =
        taskList.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList("list", sharedList);
  }

  void loadSharedPreferences() {
    List<String> sharedList = sharedPreferences.getStringList("list");
    taskList = sharedList.map((item) => TaskModel.fromMap(json.decode(item))).toList();
    print(sharedList);
    setState(() {});
  }
}
