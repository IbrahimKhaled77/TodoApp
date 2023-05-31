

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:totdo/shered/cubit/cubit.dart';

Widget buildItemUi(Map model, context)=>Dismissible(
  background: Container(
      color:Colors.red),
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Column(

      children: [

        Row(



          children: [

            CircleAvatar(

              radius: 45.0,

              child: Text('${model['time']}'),



            ),

            SizedBox(width: 15.0,),

            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text('${model['name']}',

                    style: TextStyle(

                      fontWeight: FontWeight.w500,

                      fontSize: 19.0,

                    ),

                  ),

                  SizedBox(height: 8.0,),

                  Text('${model['data']}',

                    style: TextStyle(

                      fontWeight: FontWeight.w500,

                      fontSize: 19.0,

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

            ),

            IconButton(

                onPressed: (){

                  CubitTodo.get(context).updateDataBase(id: model['id'], status: 'done');

                },

                icon: Icon(Icons.done,color: Colors.green,),

            ),

            IconButton(

              onPressed: (){

                CubitTodo.get(context).updateDataBase(id: model['id'], status: 'archie');

              },

              icon: Icon(Icons.archive, color: Colors.blue,),

            ),

          ],

        ),



      ],

    ),

  ),
  onUpdate: (value){
    CubitTodo.get(context).deleteDataBase(id: model['id']);
  },
 /* onDismissed: (value){
    CubitTodo.get(context).deleteDataBase(id: model['id']);
  },*/
);




Widget buildItem(List list)=>ListView.separated(
  itemCount:list.length,
  itemBuilder:(context,index)=>buildItemUi(list[index],context),
  separatorBuilder:(context,index)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      padding: EdgeInsetsDirectional.only(
          start: 10.0
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  ) ,

);

Widget buildCondition(list)=>ConditionalBuilder(
  builder:(context)=>buildItem(list) ,
  fallback:(context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,size: 30.0,),
        Text('Not Found',style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w600,
        ),),
      ],
    ),
  ) ,
  condition: true,

);