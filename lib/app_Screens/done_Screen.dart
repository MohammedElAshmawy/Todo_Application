import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/shared_Components/components.dart';
import 'package:todo_application/todo_cubit/cubit.dart';
import 'package:todo_application/todo_cubit/states.dart';

class done_screen extends StatelessWidget {
  const done_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<todo_cubit,appStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var tasks=todo_cubit.get(context).done;
        return Scaffold(

            body:ListView.separated(
                itemBuilder:(context,index)=>buildTaskItem(tasks[index],context),
                separatorBuilder: (context,index)=>Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                itemCount: tasks.length
            )
         );
        },
       );
      }
     }
