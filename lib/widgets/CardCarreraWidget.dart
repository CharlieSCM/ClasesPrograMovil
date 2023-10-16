import 'package:flutter/material.dart';
import 'package:login/database/agendaDB.dart';
import 'package:login/models/carrera_model.dart';

class CardCarreraWidget extends StatefulWidget {
  const CardCarreraWidget({super.key, required CarreraModel carreraModel, AgendaDB? agendaDB});

  @override
  State<CardCarreraWidget> createState() => _CardCarreraWidgetState();
}

class _CardCarreraWidgetState extends State<CardCarreraWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}