import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/todo_cubit/cubit.dart';
import 'package:todo_application/todo_cubit/states.dart';

class todo_home extends StatelessWidget
{
  // TO TOGGLE BETWEEN ANY WIDGET CREATE A LIST!!!!!
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();

  var textcontroller= TextEditingController();
  var timeController=TextEditingController();
  var datecontroller=TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>todo_cubit()..createDataBase(),

      child: BlocConsumer<todo_cubit,appStates>(
       listener: (context,states){
         if(states is appInsetToDataBase){
           Navigator.pop(context);
         }
       },
       builder: (context,states)
       {
       todo_cubit cubit=todo_cubit.get(context);
         return Scaffold(

           key: scaffoldKey,
           appBar: AppBar(
             title: Text(
                 'Todo app'
             ),
           ),
           body: cubit.screens[cubit.current_index],

           floatingActionButton: FloatingActionButton(
             onPressed: ()
             {
               if(cubit.isButtomSheetShown){
                 if(formKey.currentState!.validate()){
                   cubit.insertToDatabase(
                       title: textcontroller.text,
                       time: timeController.text,
                       date: datecontroller.text);
                   }
               }
               else{
                 scaffoldKey.currentState!.showBottomSheet((context) =>
                     SingleChildScrollView(
                       child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Container(
                           color: Colors.grey[100],
                           child: Form(
                             key: formKey,
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 TextFormField(
                                   controller: textcontroller ,
                                   validator: (value){
                                     if(value!.isEmpty){
                                       return('It must not be empty!');
                                     }
                                     return null;
                                   },
                                   keyboardType: TextInputType.text,
                                   decoration: InputDecoration(
                                     labelText: 'Task Title',
                                     prefix: Icon(Icons.title),
                                     border: OutlineInputBorder(),
                                   ),
                                 ),
                                 SizedBox(
                                   height: 10,
                                 ),
                                 TextFormField(
                                   onTap: (){
                                     showTimePicker(
                                         context: context,
                                         initialTime: TimeOfDay.now()

                                     ).then((value) => {
                                       timeController.text=value!.format(context),
                                     });

                                   },
                                   controller:timeController,
                                   validator: (value){
                                     if(value!.isEmpty){
                                       return('Time must not be empty!');
                                     }
                                     return null;
                                   },
                                   keyboardType: TextInputType.datetime,
                                   decoration: InputDecoration(
                                     labelText: 'Time Title',
                                     prefix: Icon(Icons.watch_later_outlined),
                                     border: OutlineInputBorder(),
                                   ),
                                 ),
                                 SizedBox(
                                   height: 10,
                                 ),

                                 TextFormField(
                                   onTap: (){
                                     showDatePicker(context: context,
                                         initialDate: DateTime.now(),
                                         firstDate: DateTime.now(),
                                         lastDate: DateTime(2040)
                                     ).then((value) {

                                       print(DateFormat.yMMMd().format(value!));
                                       datecontroller.text=DateFormat.yMMMd().format(value);
                                     });
                                   },

                                   controller: datecontroller,
                                   validator: (value){
                                     if(value!.isEmpty){
                                       return('It must not be empty!');
                                     }
                                     return null;
                                   },
                                   keyboardType: TextInputType.text,
                                   decoration: InputDecoration(
                                     labelText: 'Date Title',
                                     prefix: Icon(Icons.calendar_today_outlined),
                                     border: OutlineInputBorder(),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),
                     ),
                 ).closed.then((value)
                 {
                   cubit.changeButtomSheet(
                       isShow: false,
                       Icon: Icons.add);
                 });
                   cubit.changeButtomSheet(
                     isShow: true,
                     Icon: Icons.edit);
               }
             },
             child: Icon(
                 cubit.fabIcon
             ),
           ),
           bottomNavigationBar: BottomNavigationBar(
             elevation: 5,
             type: BottomNavigationBarType.fixed,
             currentIndex: cubit.current_index,
             onTap: (index) {
               cubit.changeNavBottom(index);
             },
             items: [
               BottomNavigationBarItem(
                 icon: Icon(
                   Icons.menu,
                 ),
                 label: 'Tasks',
               ),
               BottomNavigationBarItem(
                 icon: Icon(
                   Icons.done,
                 ),
                 label: 'Done',
               ),
               BottomNavigationBarItem(
                 icon: Icon(
                   Icons.archive,
                 ),
                 label: 'Archeived',
               ),

             ],
           ),


         );

       },
      ),
    );
  }



}










