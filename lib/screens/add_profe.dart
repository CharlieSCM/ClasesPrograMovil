import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:login/database/agendaDB.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/models/carrera_model.dart';

class AddProfesor extends StatefulWidget {
  AddProfesor({super.key, this.profesorModel});

  ProfesorModel? profesorModel;

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {
    TextEditingController txtConName = TextEditingController();
    TextEditingController txtConEmail = TextEditingController();
    //TextEditingController txtConEma = TextEditingController();
    //TextEditingController txtConIdCarrera = TextEditingController();
    CarreraModel? dropDownValue;
    //String? dropDownValue = 'Pendiente';
    List<CarreraModel>? dropDownValues;
      //'Pendiente', 'Completado', 'En Proceso'
      
  AgendaDB? agendaDB;

@override
void initState() {
  super.initState();
  agendaDB = AgendaDB();
    if(widget.profesorModel != null){
    txtConName.text = widget.profesorModel!.nomProfe!;
    txtConEmail.text = widget.profesorModel!.email!;
    getCareer();
    }else{
      getCareers();
    }
  }

  Future getCareer() async {
    final career = await agendaDB!.GETCAREER(widget.profesorModel!.idCarrera!);
    final careers = await agendaDB!.GETALLCARRERA();
    setState(() {
      dropDownValues = careers;
      for (int i = 0; i < careers.length; i++) {
        if (careers[i].idCarrera == career.idCarrera) {
          dropDownValue = careers[i];
          break;
        }
      }
    });
  }

  Future getCareers() async {
    final careers = await agendaDB!.GETALLCARRERA();
    setState(() {
      dropDownValues = careers;
      dropDownValue = careers[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtTeacherName = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre de Profesor")),
      controller: txtConName,
    );

    final txtTeacherEmail = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Correo Electronico")),
      controller: txtConEmail,
    );

    const space = SizedBox(
      height: 10,
    );

    final btnSave = ElevatedButton(
        onPressed: () {
          if (widget.profesorModel == null) {
            if (txtConName.text == "" ||
                txtConEmail.text == "") {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: "¡Advertencia!",
                      text: "Porfavor, llenar todos lo espacios"));
            } else {
              agendaDB!.INSERT('tblProfesor', {
                "nomProfe": txtConName.text,
                "email": txtConEmail.text,
                "idCarrera": dropDownValue!.idCarrera
              }).then((value) {
                var msj = (value > 0)
                    ? 'Profesor Agregado Correctamente'
                    : 'Algo Fallo';
                var snackBar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              });
            }
          } else {
            agendaDB!.UPDATE('tblProfesor', 'idProfe', {
              "idProfe": widget.profesorModel!.idProfe,
              "nomProfe": txtConName.text,
              "email": txtConEmail.text,
              "idCarrera": dropDownValue!.idCarrera
            }).then((value) {
              var msj = (value > 0)
                  ? 'Profesor Actualizado Correctamente'
                  : 'Algo Fallo';
              var snackBar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          }
          GlobalValues.flag_database.value = !GlobalValues.flag_database.value;
        },
        child: const Text("Guardar"));

    final DropdownButton dropDownButtonCareer = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            ?.map((career) => DropdownMenuItem(
                value: career, child: Text(career.nomCarrera!)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    return Scaffold(
      appBar: AppBar(
        title: widget.profesorModel == null
            ? const Text('Agregar Profesor')
            : const Text('Actualizar Profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            txtTeacherName,
            space,
            txtTeacherEmail,
            space,
            dropDownButtonCareer,
            space,
            btnSave
          ],
        ),
      ),
    );
  }
}