class TaskModel {
  int? idTask;
  String? nameTask;
  String? dscTask;
  int? sttTask;
  String? fecExpiracion;
  String? fecRecordatorio;
  int? idProfe;

  TaskModel({this.idTask, this.nameTask, this.dscTask, this.sttTask, this.fecExpiracion, 
              this.fecRecordatorio, this.idProfe});
              
  factory TaskModel.fromMap(Map<String,dynamic> map){
    return TaskModel(
      idTask: map['idTask'],
      dscTask: map['dscTask'],
      nameTask: map['nameTask'],
      sttTask: map['sttTask'],
      fecExpiracion: map['fecExpiracion'],
      fecRecordatorio: map['fecRecordatorio'],
      idProfe: map['idProfe']
    );
  }
}