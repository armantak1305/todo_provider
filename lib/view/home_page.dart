import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dbprovider.dart';
import '../todo_model.dart';
import 'add_edit.dart';




class HomePage extends StatelessWidget{
  DateFormat mFormat =DateFormat.yMMMd().add_jm();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DBProvider>().getInitialNote();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Todos"),
      ),
      body: Consumer<DBProvider>(builder: (_,provider,__){
        provider.getInitialNote();
        List<TodoModel> allTodos=provider.getTodo();
        return allTodos.isNotEmpty?ListView.builder(itemBuilder: (_,index){
          return Stack(
            children: [
              ///Title and Description..
              Card(
                margin: const EdgeInsets.all(10),
                color: allTodos[index].isComplete==1?Colors.green:Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: CheckboxListTile(
                  contentPadding:const EdgeInsets.only(bottom: 20),
                  value: allTodos[index].isComplete==1,
                  onChanged: (value) {
                    var updateTodo =TodoModel(title: allTodos[index].title, desc: allTodos[index].desc,sno: allTodos[index].sno,isComplete: value!?1:0,create_at: allTodos[index].create_at);
                    provider.checkBoxUpdate(checkBoxUpdate: updateTodo, sno: allTodos[index].sno!, value: value);
                  },
                  ///Title and Edit and Delete Button...
                  title: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.9,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          allTodos[index].title,style: TextStyle(decoration: allTodos[index].isComplete==1?TextDecoration.lineThrough:TextDecoration.none),),
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(isUpdate: true,title: allTodos[index].title,desc: allTodos[index].desc,sno: allTodos[index].sno!,complete: allTodos[index].isComplete),));
                          }, icon: const Icon(Icons.edit)),
                          IconButton(onPressed: (){
                            context.read<DBProvider>().deleteTodo(sno: allTodos[index].sno!);
                          }, icon: const Icon(Icons.delete,color: Colors.red,)),
                        ],
                      )
                    ],
                  ),
                  ///Descriptions...
                  subtitle: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,

                      allTodos[index].desc,style: TextStyle(decoration:allTodos[index].isComplete==1?TextDecoration.lineThrough:TextDecoration.none ),),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              ///Todo created Date-Time
              Positioned(
                bottom: 10,
                right: 20,
                child: Text(mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(allTodos[index].create_at)))),)
            ],

          );

        },
          itemCount: allTodos.length,
        ):const Center(child: Text("Oops No Todo Yet!!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),);
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add TODO",
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 10,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPage()));
        },child: const Icon(Icons.add),),
    );
  }

}