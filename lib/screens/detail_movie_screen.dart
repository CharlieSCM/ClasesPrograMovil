import 'package:flutter/material.dart';
import 'package:login/models/popular_model.dart';

class DetailMovieScreenState extends StatefulWidget {
  const DetailMovieScreenState({super.key});

  @override
  State<DetailMovieScreenState> createState() => _DetailMovieScreenStateState();
}

class _DetailMovieScreenStateState extends State<DetailMovieScreenState> {
  
  PopularModel? movie;

  @override
  Widget build(BuildContext context) {
      movie = ModalRoute.of(context)!.settings.arguments as PopularModel; 
    return Scaffold(
      body: Center(child: Text(movie!.title!)),
    );
  }
}