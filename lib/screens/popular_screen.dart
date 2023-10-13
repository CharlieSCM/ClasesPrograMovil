import 'package:flutter/material.dart';
import 'package:login/models/popular_model.dart';
import 'package:login/services/api_popular.dart';
import 'package:login/widgets/item_movie_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Peliculas Populares"),),
      body: FutureBuilder(
        future:apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, 
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10, 
              childAspectRatio: .9
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return itemMovieWidget(snapshot.data![index], context);
              }
            );
          }else{
            if(snapshot.hasError){
              return Center(child: Text("Error al cargar los datos"),);
            
          }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
      )
    );
  }  
}
/*import 'package:flutter/material.dart';
import 'package:login/models/popular_model.dart';
import 'package:login/services/api_popular.dart';
import 'package:login/widgets/item_movie_widget.dart';

class PopulasScreen extends StatefulWidget {
  const PopulasScreen({super.key});

  @override
  State<PopulasScreen> createState() => _PopulasScreenState();
}

class _PopulasScreenState extends State<PopulasScreen> {

  ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Peliculas Populares"),),
      body: FutureBuilder(
        future:apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, 
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10, 
              childAspectRatio: .9
              
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return itemMovieWidget(snapshot.data![index]);
              }
            );
          }else{
            if(snapshot.hasError){
              return Center(child: Text("Error al cargar los datos"),);
            
          }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        }
      )
    );
  }
}*/