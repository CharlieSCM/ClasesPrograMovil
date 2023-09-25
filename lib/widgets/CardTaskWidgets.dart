import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/task_model.dart';
import 'package:login/screens/add_task.dart';

class CardTaskWidget extends StatefulWidget {
  CardTaskWidget(
    {super.key, required this.taskModel, 
    this.agendaDB} 
  );

// las llaves significasn nomnbrados

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState extends State<CardTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Row(
        children: [
          Column(
            children: [Text(widget.taskModel.nameTask!), Text(widget.taskModel.dscTask!)],

          ),
          Expanded(
            child: Container()
            ),
          Column(
            children: [
              GestureDetector(
                onTap: ()=> Navigator.push( 
                  context,
                  MaterialPageRoute(
                    builder: (context)=>
                    AddTask(taskModel: taskModel
                    )
                  )
                ),
                child: Image.asset('assets/fresa.pgn', height: 50,),
              ),
              IconButton(onPressed: (){
                showDialog(
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title: Text('Mensaje del sistema'),
                      content: Text('Deseas borrar la tarea?'),
                      actions: [
                        TextButton(
                          onPressed:(){
                            widget.agendaDB!.DELETE('tblTareas', widget.taskModel.idTask!).then((value) {
                              Navigator.pop(context);
                              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                            });
                          }, 
                          child: Text('Si')
                        ),
                        TextButton(
                          onPressed:()=>Navigator.pop(context), 
                          child: Text('No')
                        ),
                      ],
                    );
                  },
                );
              }, 
              icon: Icon(Icons.delete)
              )
            ],
          ),
        ],
      ),
    );
  }
}
