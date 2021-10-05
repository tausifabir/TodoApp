import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TaskModel.dart';

class CompletedTask extends StatefulWidget {


  @override
  _CompletedTaskState createState() => _CompletedTaskState();


}


class _CompletedTaskState extends State<CompletedTask> {
  late List<TaskModel> completeTaskList = [];
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
      ),
      body: completeTaskList.isNotEmpty ? buildBody() : buildNotBody(),
    );

  }


  Widget buildBody() {
    return ListView.builder(
        itemCount: completeTaskList.length,
        itemBuilder: (context, index) {
          return buildItem(completeTaskList[index]);
        });
  }

  Widget buildNotBody() {
    return Center(
      child: Text("No Item"),
    );
  }

  Widget buildItem(TaskModel item) {
    return ListTile(
        title: Text(item.title),
        trailing: Checkbox(
          value: item.complete,
          onChanged: null,
          activeColor: Colors.purple,
        ),

      );

  }

  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadSharedPreferences();
  }

  void loadSharedPreferences() {
    List<String> sharedList = sharedPreferences.getStringList("list");
    completeTaskList = sharedList.map((item) => TaskModel.fromMap(json.decode(item))).toList();
    print(sharedList);
    setState(() {});
  }


}
