import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/task_model.dart';
import 'package:login/widgets/CardTaskWidgets.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  AgendaDB? agendaDB;

  @override
  void initState(){
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/add'), 
            icon: Icon(Icons.task)
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagTask,
        builder: (context, value, _) {
          return FutureBuilder(
            future: agendaDB!.GETALLTASK(),
            builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot){
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index){
                      return CardTaskWidget(
                      taskModel: snapshot.data![index],agendaDB:agendaDB,
                      ); 
                    }
                  );
              }else{
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro!'),
                  );
                }else{
                  return CircularProgressIndicator();
                }
              }
            }
          );
        }
      ),
    );
  }
}