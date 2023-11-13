import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:login/firebase/favorites_firebase.dart';

class PopularFirebasScreen extends StatefulWidget {
  const PopularFirebasScreen({super.key});

  @override
  State<PopularFirebasScreen> createState() => _PopularFirebasScreenState();
}

class _PopularFirebasScreenState extends State<PopularFirebasScreen> {

  FavoritesFirebase? _favoritesFirebase;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritesFirebase = FavoritesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _favoritesFirebase!.getAllFavorites(), 
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return  ListView.builder(
            itemBuilder: (context, index) {
              return Text(snapshot.data!.docs[index].get('title'));
            },
          );
        }else{
          if (snapshot.hasError) {
            return Center(child: Text('Error'),);
          }
          else{
            return Center(child: CircularProgressIndicator(),)
          }
        }
      },
    );
  }
}