import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/assets/global_values.dart';

class AddCareerScreen extends StatefulWidget {
  AddCareerScreen({super.key, this.carreraModel});

  CarreraModel? carreraModel;

  @override
  State<AddCareerScreen> createState() => _AddCareerScreenState();
}

class _AddCareerScreenState extends State<AddCareerScreen> {
  TextEditingController txtContCareerName = TextEditingController();
  AgendaDB? agendaDB;


  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    txtContCareerName.text =
        widget.carreraModel == null ? "" : widget.carreraModel!.nomCarrera!;
  }

  @override
  Widget build(BuildContext context) {
    final txtCareerName = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Agregar Carrera")),
      controller: txtContCareerName,
    );

    final btnSave = ElevatedButton(
        onPressed: () {
          if (widget.carreraModel == null) {
            if (txtContCareerName.text == "") {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: "¡Advertencia!",
                      text: "Porfavor, llenar todos lo espacios"));
            } else {
              agendaDB!.INSERT('tblCarrera',
                  {'nomCarrera': txtContCareerName.text}).then((value) {
                var msj = (value > 0)
                    ? 'Carrera agregada Correctamente'
                    : 'Algo Fallo';
                var snackBar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              });
            }
          } else {
            agendaDB!.UPDATE('tblCarrera', 'idCarrera', {
              "idCarrera": widget.carreraModel!.idCarrera,
              "nomCarrera": txtContCareerName.text
            }).then((value) {
              var msj = (value > 0)
                  ? 'Carrera Actualizada Correctamente'
                  : 'Algo Fallo';
              var snackBar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          }
          GlobalValues.flag_database.value = !GlobalValues.flag_database.value;
        },
        child: const Text("Guardar"));

    const space = SizedBox(
      height: 10,
    );

    return Scaffold(
      appBar: AppBar(
        title: widget.carreraModel == null
            ? const Text('Agregar Carrera')
            : const Text('Actualizar Carrera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [txtCareerName, space, btnSave],
        ),
      ),
    );
  }
}
