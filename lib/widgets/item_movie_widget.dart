import 'package:flutter/material.dart';
import 'package:login/models/popular_model.dart';

Widget itemMovieWidget(PopularModel movie){

  return FadeInImage(
    fit: BoxFit.fill,
  placeholder: const AssetImage('assets/loading.gif'),
  fadeInDuration: const Duration(milliseconds: 200),
  image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}')
  );

}