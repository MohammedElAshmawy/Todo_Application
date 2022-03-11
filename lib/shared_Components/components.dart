import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/todo_cubit/cubit.dart';

Widget defaultButton({
  required double width,
  required Color background,
  required Function function,
  required String text,
}) => Container(
      width: width,
      color: background,

      child: MaterialButton(

         onPressed:(){function;},
         child: Text(
           text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );


Widget buildTaskItem(Map model,context)=>

    Dismissible(
      
      key: UniqueKey(),
      child: Padding(
      padding: const EdgeInsets.all(10.0),
       child: Row(
        children: [
         CircleAvatar(
          radius: 35,
          backgroundColor: Colors.blue,
          child: Text(
            '${model['date']}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              Text(
                '${model['time']}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey
                ),
              ),
              SizedBox(
                width: 20,
              ),

            ],
          ),
        ),
        SizedBox(width: 20,
        ),
        IconButton(
          onPressed: (){
            todo_cubit.get(context).updateDataBase(status: 'done', id: model['id']);
          },
          icon: Icon(Icons.check_box),
          color: Colors.green,

        ),
        IconButton(
          onPressed: (){
           todo_cubit.get(context).updateDataBase(status: 'archived', id:model['id']);
          },
          icon: Icon(Icons.archive),
          color: Colors.grey,
        ),
      ],
     ),
    ),
      onDismissed:(direction){
        todo_cubit.get(context).deleteDataBase(id: model['id']);
      }
    );
