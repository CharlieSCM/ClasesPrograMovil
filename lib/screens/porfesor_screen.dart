import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/widgets/CardProfesorWidget.dart';

class ProfeScreen extends StatefulWidget {
  const ProfeScreen({super.key});

  @override
  State<ProfeScreen> createState() => _ProfeScreenState();
}

class _ProfeScreenState extends State<ProfeScreen> {
  AgendaDB? agendaDB;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profes'),
        actions: [
          IconButton(
              onPressed: () async {
                var res = await agendaDB!.GETALLCARRERA();
                if (res.isEmpty) {
                  ArtSweetAlert.show(
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                          type: ArtSweetAlertType.danger,
                          title: "¡Debe insertar Carrera!",
                          text:
                              "Registra por lo menos una carrera para agregar profesores"));
                } else {
                  Navigator.pushNamed(context, '/addTeacher');
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flag_database,
          builder: (context, value, _) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Buscar...",
                    ),
                    controller: searchController,
                    onChanged: (text) {
                      GlobalValues.flag_database.value =
                          !GlobalValues.flag_database.value;
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                      future:
                          agendaDB!.GETFILTEREDTEACHERS(searchController.text),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ProfesorModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return teacherWidget(
                                    snapshot.data![index], context);
                              });
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Algo fallo"),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }
                      }),
                ),
              ],
            );
          }),
    );
  }
}


/*class ProfesorScreen extends StatefulWidget {
  const ProfesorScreen({super.key});

  @override
  State<ProfesorScreen> createState() => _ProfesorScreenState();
}

class _ProfesorScreenState extends State<ProfesorScreen> {

AgendaDB? agendaDB;

@override
void initState(){
      super.initState();
      agendaDB = AgendaDB();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text("Profesores"),
        actions:[
            IconButton(
              onPressed:()=>Navigator.pushNamed(context, '/profesor')
              .then((value) {
                  setState(() {});
                }
                ),
              icon: Icon(Icons.task)
            )
        ],
      ), 
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagTask,
        builder: (context,value,_) {
          return FutureBuilder(
            future: agendaDB!.GETALLPROFE(),
            builder: (BuildContext context, AsyncSnapshot<List<ProfesorModel>> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return CardProfesorWidget(
                      profesorModel: snapshot.data![index],
                      agendaDB:agendaDB
                    );
                  }
                );
              }else{
                if(snapshot.hasError){
                  return const Center(
                    child: Text("No hay nadie registrado"),
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              }
            }
          );
        }
      ),
);
  }
}*/