import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_app/main.dart' as app;


void main(){
  
 group("Todo App",(){
   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
   testWidgets("full app test",(tester)async{

     app.main();
     await tester.pumpAndSettle();
     final submitTask = find.byKey(Key('createTask'));
     final checkBtn = find.byKey(Key("checkBox"));
     final addTaskBtn = find.byKey(Key("floatingBtn"));
     final saveBtn = find.byKey(Key("saveBtn"));

     await tester.tap(addTaskBtn);
     await tester.pumpAndSettle();
     await tester.enterText(submitTask, "Task3");
     await tester.pumpAndSettle();
     await tester.tap(saveBtn);



   });

 });
}