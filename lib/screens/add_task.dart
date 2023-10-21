import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/models/task_model.dart';

class AddTask extends StatefulWidget {
   AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

    TextEditingController txtContTaskName = TextEditingController();
    TextEditingController txtContTaskDesc = TextEditingController();
    TextEditingController txtContTaskExp = TextEditingController();
    String? reminder;
    ProfesorModel? dropDownValue;
    List<ProfesorModel>? dropDownValues; 
    DateTime? pickedDate;

    AgendaDB? agendaDB;

    String? dropValueState = "Sin Completar";
    List<String>? dropStateValues = ["Sin Completar", "Completada"];

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();

    if (widget.taskModel != null) {
      txtContTaskName.text = widget.taskModel!.nameTask!;
      txtContTaskDesc.text = widget.taskModel!.dscTask!;
      txtContTaskExp.text = widget.taskModel!.fecExpiracion!;
      reminder = widget.taskModel!.fecRecordatorio!;
      dropValueState =
          widget.taskModel!.sttTask! == 0 ? "Sin Completar" : "Completada";
      getTeacher();
    } else {
      getTeachers();
    }
  }

  Future getTeacher() async {
    final teacher = await agendaDB!.GETTEACHER(widget.taskModel!.idProfe!);
    final teachers = await agendaDB!.GETALLPROFE();
    setState(() {
      dropDownValues = teachers;
      for (int i = 0; i < teachers.length; i++) {
        if (teachers[i].idProfe == teacher.idProfe) {
          dropDownValue = teachers[i];
          break;
        }
      }
    });
  }

  Future getTeachers() async {
    final teachers = await agendaDB!.GETALLPROFE();
    setState(() {
      dropDownValues = teachers;
      dropDownValue = teachers[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateInput = TextField(
        controller: txtContTaskExp,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), labelText: "Fecha de Expiracion"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), //get today's date
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              txtContTaskExp.text = formattedDate;
              reminder = DateFormat('yyyy-MM-dd')
                  .format(pickedDate.subtract(const Duration(days: 1)));
            });
          } else {
            print("Date is not selected");
          }
        });

    final txtTaskName = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre de Tarea")),
      controller: txtContTaskName,
    );

    final txtTaskDesc = TextField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Descripcion")),
      maxLines: 6,
      controller: txtContTaskDesc,
    );

    const space = SizedBox(
      height: 10,
    );

    final DropdownButton dropDownButtonTeachers = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            ?.map((teacher) => DropdownMenuItem(
                value: teacher, child: Text(teacher.nomProfe!)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    final DropdownButton dropDownButtonStates = DropdownButton(
        value: dropValueState,
        items: dropStateValues
            ?.map((state) => DropdownMenuItem(value: state, child: Text(state)))
            .toList(),
        onChanged: (value) {
          dropValueState = value;
          setState(() {});
        });

    final ElevatedButton btnSave = ElevatedButton(
        onPressed: () {
          if (widget.taskModel == null) {
            if (txtContTaskName.text == "" ||
                txtContTaskDesc.text == "" ||
                txtContTaskExp.text == "") {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: "¡Advertencia!",
                      text: "Porfavor, llenar todos lo espacios"));
            } else {
              agendaDB!.INSERT('tblTareas', {
                "nameTask": txtContTaskName.text,
                "dscTask": txtContTaskDesc.text,
                "sttTask": dropValueState == "Sin Completar" ? 0 : 1,
                "fecExpiracion": txtContTaskExp.text,
                "fecRecordatorio": reminder,
                "idProfe": dropDownValue!.idProfe
              }).then((value) {
                var msj = (value > 0)
                    ? 'Tarea Agregada Correctamente'
                    : 'Algo Fallo';
                var snackBar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              });
            }
          } else {
            agendaDB!.UPDATE('tblTareas', 'idTask', {
              "idTask": widget.taskModel!.idTask,
              "nameTask": txtContTaskName.text,
              "dscTask": txtContTaskDesc.text,
              "sttTask": dropValueState == "Sin Completar" ? 0 : 1,
              "fecExpiracion": txtContTaskExp.text,
              "fecRecordatorio": reminder,
              "idProfe": dropDownValue!.idProfe
            }).then((value) {
              var msj = (value > 0)
                  ? ' Actualizada Correctamente✅'
                  : 'Algo Fallo';
              var snackBar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              txtContTaskName.text = "";
              txtContTaskDesc.text = "";
              Navigator.pop(context);
            });
          }
          GlobalValues.flag_database.value = !GlobalValues.flag_database.value;
        },
        child: widget.taskModel == null
            ? const Text("Guardar Tarea")
            : const Text("Actualizar Tarea"));

    return Scaffold(
      appBar: AppBar(
        title: widget.taskModel == null
            ? const Text("Agregar Tarea")
            : const Text("Actualizar Tarea"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              txtTaskName,
              space,
              txtTaskDesc,
              space,
              dropDownButtonTeachers,
              space,
              dateInput,
              space,
              dropDownButtonStates,
              space,
              btnSave
            ],
          ),
        ),
      ),
    );
  }
}

  /*
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
        if(widget.taskModel == null){
        agendaDB!.INSERT('tblTareas', { 
          'nameTask': txtConName.text,
          'dscTask': txtConDsc.text,
          'sttTask': dropDownValue!.substring(0,1)
        }).then((value){
          var msj = (value > 0) 
          ? 'La insercion fue correcta' 
          : 'Error';
          var snackBar = const SnackBar(content: Text('Task saved'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
        });
      }else{
         agendaDB!.UPDATE('tblTareas', {
          'idTask' : widget.taskModel!.idTask, 
          'nameTask': txtConName.text,
          'dscTask': txtConDsc.text,
          'sttTask': dropDownValue!.substring(0,1)
          }).then((value) {
            GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
            var msj = (value > 0) 
            ? 'La insercion fue correcta' 
            : 'Error';
            var snackBar = const SnackBar(
            content: Text('Task saved'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          });
        }
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
}*/