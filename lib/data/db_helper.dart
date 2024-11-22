
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


import '../todo_model.dart';

class DBhelper{
  ///singleton Instance..
  DBhelper._();
  static DBhelper getInstance()=>DBhelper._();

  static final String TODO_TABLE_NAME="todo";
  static final String COLUMN_SNO ="sno";
  static final String COLUMN_TITLE ="title";
  static final String COLUMN_DESC ="desc";
  static final String COLUMN_COMPLETE ="complete";
  static final String COLUMN_CREATE_AT ="create_at";

  ///Global Data
  Database?mdb;
  ///getDb and openDB...
  Future<Database> getDB()async{
    mdb??=await openDB();
    return openDB();
    /*   if(mdb!=null){
      return mdb!;
    }
    else{
      ///openDb
      mdb =await openDB();
      return mdb!;
    }*/
  }

  ///openDB..
  Future<Database> openDB()async{
    Directory appDirc =await getApplicationDocumentsDirectory();
    String dbPath =join(appDirc.path,"todoDB.db");
    return openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute("create table $TODO_TABLE_NAME ($COLUMN_SNO integer primary key autoincrement,$COLUMN_TITLE text,$COLUMN_DESC text,$COLUMN_CREATE_AT text,$COLUMN_COMPLETE integer)");
    });
  }

  ///All queries...

  ///Insert Queries...
  Future<bool> insertTodo({required TodoModel addTodo})async{
    var mDB =await getDB();
    int rowEffected =await mDB.insert(TODO_TABLE_NAME, addTodo.toMap());
    return rowEffected>0;
  }

  ///Fetch Queries...
  Future<List<TodoModel>> fetchTodo()async{
    var mDB =await getDB();
    var data = await  mDB.query(TODO_TABLE_NAME);
    List<TodoModel> mTodo=[];
    for(Map<String,dynamic> eachdata in data){
      mTodo.add(TodoModel.fromMap(eachdata));
    }
    return mTodo;
  }

  ///Update Queries..
  Future<bool> updateTodo({required TodoModel updateTodo,required int sno})async{
    var mDB=await getDB();
    int rowEffected =await mDB.update(TODO_TABLE_NAME, updateTodo.toMap(),where: "$COLUMN_SNO= ?",whereArgs: ['$sno']);
    return rowEffected>0;
  }
  ///CheckBox Value Update..
  Future<bool> checkBoxUpdate(TodoModel checkboxUp, bool value,int sno)async{
    var mDB=await getDB();
    int rowEffected =await mDB.update(TODO_TABLE_NAME,checkboxUp.toMap(),where: "$COLUMN_SNO=$sno" );
    return rowEffected>0;
  }
  Future<bool> deleteTodo({required int sno})async{
    var mDB=await getDB();
    int rowEffected = await mDB.delete(TODO_TABLE_NAME,where: "$COLUMN_SNO=?",whereArgs: ["$sno"]);
    return rowEffected>0;
  }
}