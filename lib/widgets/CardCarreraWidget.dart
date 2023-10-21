import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/screens/add_carrera.dart';
import 'package:login/assets/global_values.dart';


Widget careerWidget(CarreraModel career, BuildContext context) {
  AgendaDB? agendadb = AgendaDB();

  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.all(5),
    child: Row(
      children: [
        Column(
          children: [
            Text(
              career.nomCarrera!,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Expanded(child: Container()),
        Row(
          children: [
            SizedBox(
              width: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCareerScreen(
                                carreraModel: career,
                              )));
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Icon(
                  Icons.edit,
                  size: 14,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    ArtDialogResponse response = await ArtSweetAlert.show(
                        barrierDismissible: false,
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            denyButtonText: "Cancel",
                            title: "Are you sure?",
                            confirmButtonText: "Yes",
                            type: ArtSweetAlertType.warning));

                    if (response.isTapConfirmButton) {
                      var res = await agendadb.DELETE('tblCarrera', 'idCarrera',
                          career.idCarrera!, 'tblProfesor');
                      if (res == 0) {
                        ArtSweetAlert.show(
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                                type: ArtSweetAlertType.danger,
                                title: "¡Error!",
                                text:
                                    "There are teachers who are registered with this career"));
                      }
                      GlobalValues.flag_database.value =
                          !GlobalValues.flag_database.value;
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  child: const Icon(
                    Icons.delete,
                    size: 14,
                  )),
            )
          ],
        )
      ],
    ),
  );
}
