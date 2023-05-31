


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:totdo/model/archied.dart';
import 'package:totdo/model/done.dart';
import 'package:totdo/model/task.dart';
import 'package:totdo/shered/cubit/states.dart';

class CubitTodo extends Cubit<TotodStates>{
  CubitTodo():super(TotodInitialStates());

  static CubitTodo get(context)=>BlocProvider.of(context);

  int index=0;
  List<Widget>screen=[
    Task(),
    Done(),
    Archive(),

  ];


  List<String>titleScreen=[
    'Task',
    'Done',
    'Archive',

  ];


  List<BottomNavigationBarItem>bottom=[
    BottomNavigationBarItem(
      label: 'Task',
      icon: Icon(Icons.task_alt),
    ),
    BottomNavigationBarItem(
      label: 'Done',
      icon: Icon(Icons.done_outline_outlined),
    ),
    BottomNavigationBarItem(
      label: 'Archive',
      icon: Icon(Icons.archive_outlined),
    ),

  ];


  void changeBottom({
    required int indexs,
}){
    index=indexs;
    emit(ChangeBottomStates());
  }

  IconData icon=Icons.edit;
  bool isBottomShow=false;
  void showBottomSheet({
    required bool isShow,
    required IconData icondata,

}){

    icon=icondata;
    isBottomShow=isShow;
    emit(ChangeShowBottomSheetStates());

  }

  Database? data;

  void creatDataBase() async{

     data= await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version){
        database.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY,name TEXT,time TEXT, data TEXT,status TEXT)'
        ).then((value) {
          emit(CreatDataBaseSuccessStates());
        }).catchError((onError){
          emit(CreatDataBaseErrorStates());
        });
      },
      onOpen: (database){

        print('open database');
        getDataBase(database: database);
        emit(OpenDataBaseSuccessStates());
      },
    );
  }

  Future insertDataBase({
    required String name,
    required String time,
    required String datas,
  }) async {

   await data!.transaction((txn) =>
       txn.rawInsert('INSERT INTO task(name,time,data,status) VALUES("$name","$time","$datas","new")')
       .then((value) {
         emit(InsertDataBaseSuccessStates());
         getDataBase(database: data!);
   })
       .catchError((error){
         emit(InsertDataBaseErrorStates());
   }),
    );

  }

  List<dynamic>task=[];
  List<dynamic>done=[];
  List<dynamic>archie=[];

  void getDataBase({
    required Database database,
}) async{

    task=[];
    done=[];
    archie=[];
    emit(GetDataBaseLoadingStates());
    await
    database.rawQuery('SELECT * FROM task')
        .then((value) {
          value.forEach((element) {
            if(element['status'] =='new'){
              task.add(element);
            }else if(element['status'] =='done'){
              done.add(element);
            }else if(element['status'] =='archie') {
              archie.add(element);
            }
          });

          emit(GetDataBaseSuccessStates());
    })
        .catchError((onError){
          emit(GetDataBaseErrorStates());
    });
  }



  void updateDataBase({
    required int id,
    required String status,
})async{

    data!.rawUpdate('UPDATE task SET status=? WHERE id=?', [status,id],)
        .then((value) {

          getDataBase(database: data!);
          emit(UpdateDataBaseSuccessStates());
    })
        .catchError((onError){

          emit(UpdateDataBaseErrorStates());
    });
  }


  void deleteDataBase({
    required int id,
}) async {

    data!.rawDelete(
      'DELETE FROM task WHERE id=?', [id],
    ).then((value) {
      emit(DeleteDataBaseSuccessStates());
    })
        .catchError((onError){
          emit(DeleteDataBaseErrorStates());
    });
  }



}