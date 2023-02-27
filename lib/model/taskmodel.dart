class Task {
  int? id;
  dynamic title;
  dynamic note;
  int?  isCompleted;
  dynamic date;
  dynamic startTime;
  dynamic endTime;
  int? color;
  int? remind;
  dynamic repeat;
  Task({ this.id, this.title, this.date, this.repeat, this.endTime, this.isCompleted, this.color, this.note, this.remind, this.startTime,});
 Task.fromJson(Map<String ,dynamic>json){
  id=json["id"];
  title=json["title"];
  note=json["note"];
  isCompleted=json["isCompleted"];
  date=json["date"];
  startTime=json["startTime"];
  endTime=json["endTime"];
  color=json["color"];
  remind=json["remind"];
  repeat=json["repeat"];
}
Map<String,dynamic>toJson(){
   final Map<String,dynamic> data= new  Map<String,dynamic>();
   data["id"]=id;
   data["title"]= title;
   data["note"]= note;
   data["isCompleted"]= isCompleted;
   data["date"]= date;
   data["startTime"]= startTime;
   data["endTime"]=endTime;
   data["color"]=color;
   data["remind"]=remind;
   data["repeat"]= repeat;

   return data;
}
}