import 'package:flutter/material.dart';
import 'package:login/models/popular_model.dart';

Widget itemMovieWidget(PopularModel popularModel){

  return FadeInImage(
   placeholder: placeholder,
   image: NetworkImage('https://image.tmdb.org/t/p/w500/${popularModel.posterPath}'),
  );

}