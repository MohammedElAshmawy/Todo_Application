



import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_application/shared_Components/components.dart';
import 'package:todo_application/todo_cubit/cubit.dart';
import 'package:todo_application/todo_cubit/states.dart';

class task_screen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {


    return BlocConsumer<todo_cubit,appStates>(
       listener:(context,state){} ,
      builder: (context,state){
         var tasks=todo_cubit.get(context).newtasks;
         return ConditionalBuilder(
           condition:tasks.length>0 ,
           builder:(context)=> ListView.separated(
               itemBuilder:(context,index)=>buildTaskItem(tasks[index],context),
               separatorBuilder: (context,index)=>Container(
                 width: double.infinity,
                 height: 1,
                 color: Colors.grey[300],
               ),
               itemCount: tasks.length),
           fallback:(context)=> Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.menu,
                 size: 100,
                 color: Colors.grey,
                 ),
                 Text(
                   'No Tasks Yet please enter tasks!',
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold
                   ),
                 ),

               ],
             ),
           ),
         );


      },

    );


  }
}












