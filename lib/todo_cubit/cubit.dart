
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/app_Screens/archeived_Screen.dart';
import 'package:todo_application/app_Screens/done_Screen.dart';
import 'package:todo_application/app_Screens/task_screen.dart';
import 'package:todo_application/todo_cubit/states.dart';

class todo_cubit extends Cubit<appStates>{
  todo_cubit() : super(intitialState());

  static todo_cubit get(context)=> BlocProvider.of(context);

  int current_index = 0;
  late Database database;
  List<Map> newtasks=[];
  List<Map> done=[];
  List<Map> archeived=[];

  bool isButtomSheetShown=false;
  IconData fabIcon=Icons.edit;


  List<Widget> screens = [
    task_screen(),
    done_screen(),
    archeived_tasks()
  ];

  List<String> titles = [
    'New tasks'
        'Done tasks'
  ];

  void changeNavBottom(int index){
    current_index=index;
    emit(changeNavBottomState());

  }
  void createDataBase(){
     openDatabase(
        'Todo.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,'
                  'date TEXT,time Text,status TEXT)').then((value) {
            print('database opened');
          });
        },
        onOpen: (database) {
          getDataFromDatabase(database);
          print('database opened');
        }
    ).then((value) {
      database=value;
      emit(appCreateDataBase());
     });
  }

  void updateDataBase({
  required String status,
  required int id,
}) async{
      database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ? ',
        ['${status}', '${id}']
    ).then((value) {
      getDataFromDatabase(database);
      emit(appUpdateDataBase());
      });
  }

  void deleteDataBase({

    required int id,
  }) async{
    database.rawUpdate('DELETE FROM tasks WHERE id = ?', [id]).
    then((value) {

      getDataFromDatabase(database);
      emit(appDeleteDataBase());
    });
  }



    insertToDatabase({
    @required String? title,
    @required String? time,
    @required String? date,
  }) {
       database.transaction((txn)   async {
      txn.rawInsert('INSERT INTO tasks(title,date,time,status) '
          'VALUES("${title}","${time}","${date}","single")',
      )
          .then((value) {
        print('$value Inserted Successfully');
        emit(appInsetToDataBase());
        getDataFromDatabase(database);
      }).catchError((erorr){

      });
      return null;
    });

  }

  void getDataFromDatabase (database) {
       newtasks=[];
       done=[];
       archeived=[];

     database.rawQuery('SELECT * FROM tasks').then((value) {
       value.forEach((element)
       {
         if(element['status'] == 'single')
           newtasks.add(element);
         else if(element['status'] == 'done')
           done.add(element);
         else
           archeived.add(element);
       });
             print(newtasks);

       emit(appGetDataBase());
     });
  }

  void changeButtomSheet({
  required isShow,
  required Icon,
  })
  {
   isButtomSheetShown=isShow;
   fabIcon=Icon;
  }
}


