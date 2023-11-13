import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesFirebase{

  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  CollectionReference? _favoritesCollection;

  FavoritesFirebase(){
    _favoritesCollection = _firebase.collection('favorites');
  }

  Future<void> insFacorite(Map<String, dynamic> map) async{
    return _favoritesCollection!.doc().set(map);
  }

  Future<void> updFacorite(Map<String, dynamic> map, String id) async{
    return _favoritesCollection!.doc(id).update(map);
  }

  Future<void> delFacorite(String id) async{
    return _favoritesCollection!.doc(id).delete();
  }
  
  Stream<QuerySnapshot> getAllFavorites(){
    return _favoritesCollection!.snapshots();
  }
}