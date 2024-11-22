

import 'package:flutter/widgets.dart';
import 'package:todo_provider/todo_model.dart';

import 'data/db_helper.dart';

class DBProvider extends ChangeNotifier{
  DBhelper dBhelper;
  DBProvider({required this.dBhelper});
  List<TodoModel> _mTodo=[];
  ///Events..

  ///Add event...
  void addTodo({required TodoModel addtodo})async{
    bool isAdd =await dBhelper.insertTodo(addTodo: addtodo);
    if(isAdd){
      _mTodo =await dBhelper.fetchTodo();
      notifyListeners();
    }
  }
  ///update Events...
  void updateTodo({required TodoModel updateTodo,required int sno})async{
    bool isUpdate =await dBhelper.updateTodo(updateTodo: updateTodo, sno: sno);
    if(isUpdate){
      _mTodo=await dBhelper.fetchTodo();
      notifyListeners();
    }
  }
  ///Checkbox Update
  void checkBoxUpdate({required TodoModel checkBoxUpdate,required int sno,required bool value})async{
    var isCheck =await dBhelper.checkBoxUpdate(checkBoxUpdate, value, sno);
    if(isCheck){
      _mTodo= await dBhelper.fetchTodo();
      notifyListeners();
    }
  }
  ///Delete events..
  void deleteTodo({required int sno})async{
    bool isDelete =await dBhelper.deleteTodo(sno: sno);
    if(isDelete){
      _mTodo= await dBhelper.fetchTodo();
      notifyListeners();
    }
  }
  ///getInitialNote
  void getInitialNote()async{
    _mTodo =await dBhelper.fetchTodo();
    notifyListeners();
  }
  ///getTodo..
  List<TodoModel> getTodo()=>_mTodo;
}
