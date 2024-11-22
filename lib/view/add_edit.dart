
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../dbprovider.dart';
import '../todo_model.dart';

class AddEditPage extends StatelessWidget{
  int sno,complete;
  bool isUpdate;
  String title,desc;
  AddEditPage({this.isUpdate=false,this.title="",this.desc="",this.sno=0,this.complete=0});

  ///Controllers..
  TextEditingController titleController =TextEditingController();
  TextEditingController descController =TextEditingController();

  @override

  Widget build(BuildContext context) {
    if(isUpdate){
      titleController.text=title;
      descController.text=desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate?"Update Todo":"Add Todo"),
      ),
      body: Consumer<DBProvider>(builder: (_,provider,__){
        return Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ///Title TextField...
                SizedBox(
                  height: 100,
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    autofocus: isUpdate?false:true,
                    style: const TextStyle(fontSize: 22),
                    controller: titleController,
                    decoration:const InputDecoration(
                      hintText: "Enter Your Topics",
                    ) ,
                  ),
                ),
                const SizedBox(height: 20,),
                ///Description TextField...
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: descController,
                      style: const TextStyle(fontSize: 21),
                      expands: true,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter The Description..."
                      ),
                    ),
                  ),
                ),
                ///ADD and Cancel  Button ...
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///Add and update Buttons..
                    InkWell(
                      onTap: (){
                        if(titleController.text.isNotEmpty&&descController.text.isNotEmpty){
                          isUpdate? context.read<DBProvider>().updateTodo(updateTodo: TodoModel(title: titleController.text, desc: descController.text, create_at: DateTime.now().millisecondsSinceEpoch.toString()), sno: sno):context.read<DBProvider>().addTodo(addtodo: TodoModel(title: titleController.text, desc: descController.text,create_at: DateTime.now().millisecondsSinceEpoch.toString(),));
                          Navigator.pop(context);
                          /* bool isAdd = await myDB.insertTodo(addTodo: TodoModel(title: titleController.text, desc: descController.text));
                          if(isAdd){
                            getTODO();
                          }*/

                          // titleController.clear();
                          // descController.clear();
                          //context.read<DBprovider>().addTodo(newTodo: TodoModel(title: titleController.text, desc: descController.text));
                        }
                        else{
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.4,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            border: Border.all()
                        ),
                        child: Center(child: Text(isUpdate?"UPDATE":"ADD",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                      ),
                    ),
                    ///Cancel Button..
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.4,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            border: Border.all()
                        ),
                        child: const Center(child: Text("CANCEL",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                      ),
                    ),


                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

}