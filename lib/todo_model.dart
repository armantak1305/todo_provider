

import 'data/db_helper.dart';

class TodoModel{
  int?sno;
  String title,desc;
  String create_at;
  int isComplete;

  TodoModel({this.sno,required this.title,required this.desc,this.isComplete=0,required this.create_at});

  ///From Map to Model
  factory TodoModel.fromMap(Map<String,dynamic> map){
    return TodoModel(
        sno: map[DBhelper.COLUMN_SNO],
        title: map[DBhelper.COLUMN_TITLE],
        desc: map[DBhelper.COLUMN_DESC],
        isComplete: map[DBhelper.COLUMN_COMPLETE],
        create_at: map[DBhelper.COLUMN_CREATE_AT]
    );
  }

  ///From Model ToMap..
  Map<String,dynamic> toMap(){
    return{
      DBhelper.COLUMN_TITLE:title,
      DBhelper.COLUMN_DESC:desc,
      DBhelper.COLUMN_CREATE_AT:create_at,
      DBhelper.COLUMN_COMPLETE:isComplete
    };
  }
}