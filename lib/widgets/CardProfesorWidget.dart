import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:login/database/agendaDB.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/screens/add_profe.dart';

Widget teacherWidget(ProfesorModel teacher, BuildContext context) {
  AgendaDB? agendadb = AgendaDB();
  return FutureBuilder(
      future: agendadb.GETCAREER(teacher.idCarrera!),
      builder: (BuildContext context, AsyncSnapshot<CarreraModel> snapshot) {
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
                      teacher.nomProfe!,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data!.nomCarrera!,
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
                                  builder: (context) => AddProfesor(
                                        profesorModel: teacher,
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
                                        denyButtonText: "Cancelar",
                                        title: "Segurito?",
                                        confirmButtonText: "Si",
                                        type: ArtSweetAlertType.warning));

                            if (response.isTapConfirmButton) {
                              var res = await agendadb.DELETE('Profe',
                                  'teacher_id', teacher.idProfe!, 'tasks');
                              if (res == 0) {
                                ArtSweetAlert.show(
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.danger,
                                        title: "¡Error!",
                                        text:
                                            "There are tasks which are registered with this teacher"));
                              }
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
                            Icons.delete,
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
              child: Text("Something Was Wrong"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      });
}

/*import 'package:flutter/material.dart';
import 'package:login/database/agendaDB.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/screens/add_profe.dart';

class CardProfesorWidget extends StatelessWidget {
  CardProfesorWidget({super.key, required this.profesorModel, this.agendaDB});

  ProfesorModel profesorModel;
  AgendaDB? agendaDB;

  @override
  
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(  
        color: Colors.amber
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(profesorModel.nomProfe!),
              Text(profesorModel.email!),
              Text(profesorModel.idCarrera! as String),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddProfesor(profesorModel: profesorModel))) ,
                child: Image.asset('assets/fresa.png',height: 50,)
                ),
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context){
                    return AlertDialog(
                      title: Text('Mensaje del sistema'),
                      content: const Text('¿Deseas eliminar al profesor?'),
                      actions: [
                        TextButton(onPressed: (){
                          agendaDB!.DELETE('tblProfesor', profesorModel.idProfe).then((value){
                            Navigator.pop(context);
                            GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                          });
                        }, child: Text('Si')),
                        TextButton(
                          onPressed:()=>Navigator.pop(context), child: Text('No')
                          )

                      ],
                    );
                  },);
                }, 
              icon: Icon(Icons.delete)
              )
            ],
          )
        ],
      ),
    );
  }
}*/