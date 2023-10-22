import 'package:flutter/material.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/widgets/CardCarreraWidget.dart';
import 'package:login/assets/global_values.dart';


class CarreraScreen extends StatefulWidget {
  const CarreraScreen({super.key});

  @override
  State<CarreraScreen> createState() => _CarreraScreenState();
}

class _CarreraScreenState extends State<CarreraScreen> {
  AgendaDB? agendaDB;

 TextEditingController searchController = TextEditingController();

@override
void initState(){
      super.initState();
      agendaDB = AgendaDB();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador de Carreras'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addCareer');
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
                          agendaDB!.GETFILTEREDCAREERS(searchController.text),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CarreraModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return careerWidget(
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

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carreras"),
        actions:[
            IconButton(
              onPressed:()=>Navigator.pushNamed(context, '/carrera')
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
            future: agendaDB!.GETALLCARRERA(),
            builder: (BuildContext context, AsyncSnapshot<List<CarreraModel>> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return CardCarreraWidget(
                      carreraModel: snapshot.data![index],
                      agendaDB:agendaDB
                    );
                  }
                );
              }else{
                if(snapshot.hasError){
                  return const Center(
                    child: Text("NO HAY CARRERAS REGISTRADAS"),
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              }
            }
          );
        }
      ),);
  }
}*/