import 'package:flutter/material.dart';
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
         if (snapshot.hasData) {
           
         return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return itemMovieWidget(snapshot.data![index]);
          },
         );
        }else{
          if (snapshot.hasData) {
            return Center(child: Text('Algo salio mal'),);
          }else{
            return CircularProgressIndicator();
          }
        }  
      },
      )
    );
  }
}