import 'package:flutter/material.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/task_model.dart';

class AddTask extends StatefulWidget {
   AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

    String? dropDownValue;
    TextEditingController txtConName = TextEditingController();
    TextEditingController txtConDsc = TextEditingController();
    //String dropDownValue = "Pendiente";
    List<String> dropDownValues = [
      'Pendiente', 'Completado', 'En Proceso', 'Sin iniciar'
    ];

    AgendaDB? agendaDB;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();

    if(widget.taskModel != null){
      txtConName.text = widget.taskModel!.nameTask!; 
      txtConDsc.text = widget.taskModel!.dscTask!;

      switch(widget.taskModel!.sttTask){
        case 'P': dropDownValue = "Pendiente"; break;
        case 'C': dropDownValue = "Completado"; break;
        case 'E': dropDownValue = "En Proceso"; break;
        //default: dropDownValue = "Pendiente";
      }
    }

    
  }

  @override
  Widget build(BuildContext context) {
    

    final txtNameTask = TextField(
      decoration: InputDecoration(
        label: Text('Tareas'),
        border: OutlineInputBorder()
      ),
      controller: txtConName,
    );

    final txtDscTask = TextField(
      decoration: InputDecoration(
        label: Text('Tareas'),
        border: OutlineInputBorder()
      ),
      maxLines: 6,
      controller: txtConDsc,
    );

    final space = SizedBox(height: 10,);

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Text(status)
        )
      ).toList(), 
      onChanged: (value){
        dropDownValue = value;
        setState(() {});
      }
    );

    final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: (){
        agendaDB!.INSERT('tblName', {
          'nameTask': txtConName.text,
          'dscTask' : txtConDsc.text,
          'sstTask': dropDownValue!.substring(0,1)

        }).then((value){
          var msj = (value > 0)
        ? 'Las insercion fue exitosa'
        : 'Ocurrio un error';
          var snackBar = const SnackBar(content: Text('Saved text'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }); 
      }, 
      child: Text('Save Task')
    );

    return Scaffold(
      appBar: AppBar(
        title: widget.taskModel == null 
        ?Text('Add Task')
        :Text('Update task'),
      ),
      body: Column(
        
        children: [
          txtNameTask,
          space,
          txtDscTask,
          space,
          ddBStatus,
          btnGuardar
        ],
      ),
    );
  }
}