import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:login/database/agendaDB.dart';
import 'package:login/models/task_model.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/screens/add_task.dart';
import 'package:login/models/profesor_model.dart';

Widget taskWidget(TaskModel task, BuildContext context) {
  AgendaDB? agendadb = AgendaDB();
  return FutureBuilder(
      future: agendadb.GETTEACHER(task.idProfe!),
      builder: (BuildContext context, AsyncSnapshot<ProfesorModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.nameTask!,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data!.nomProfe!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 12))
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
                                  builder: (context) => AddTask(
                                        taskModel: task,
                                      )));
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
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
                            ArtDialogResponse response =
                                await ArtSweetAlert.show(
                                    barrierDismissible: false,
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                        denyButtonText: "No",
                                        title: "Esta seguro de esto?",
                                        confirmButtonText: "Si",
                                        //type: ArtSweetAlertType.question
                                        ));

                            if (response.isTapConfirmButton) {
                              agendadb.DELETE(
                                  'tblTareas', 'idTask', task.idTask!, null);
                              GlobalValues.flag_database.value =
                                  !GlobalValues.flag_database.value;
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero)),
                          child: const Icon(
                            Icons.clear,
                            size: 14,
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      });
}
