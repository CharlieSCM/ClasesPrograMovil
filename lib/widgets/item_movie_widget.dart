import 'package:flutter/material.dart';
import 'package:login/models/popular_model.dart';


class ItemPopularMovie extends StatelessWidget {
  ItemPopularMovie({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: const AssetImage('assets/loading.gif'),
      image: NetworkImage(
          'https://image.tmdb.org/t/p/w500/${popularModel.posterPath}'),
    );
  }
}

/*Widget itemMovieWidget(PopularModel movie, context){

  return GestureDetector(
    onTap: () => Navigator.pushNamed(
      context, '/detail', 
      arguments: movie
    ), 
    child: FadeInImage(
      fit: BoxFit.fill,
    placeholder: const AssetImage('assets/loading.gif'),
    fadeInDuration: const Duration(milliseconds: 200),
    image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}')
    ),
  );

}*/