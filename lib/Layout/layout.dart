import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:totdo/shered/cubit/cubit.dart';
import 'package:totdo/shered/cubit/states.dart';

class LayoutTodot extends StatelessWidget {
   LayoutTodot({Key? key}) : super(key: key);

   var scaffoldKey=GlobalKey<ScaffoldState>();
   var keyFrom=GlobalKey<FormState>();
   var textController=TextEditingController();
   var timeController=TextEditingController();
   var dateController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CubitTodo()..creatDataBase(),
      child: BlocConsumer<CubitTodo,TotodStates>(
       listener: (context , state){},
        builder: (context,state) {
         var cubit=CubitTodo.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titleScreen[cubit.index]),
            ),
           body:cubit.screen[cubit.index] ,
           floatingActionButton: FloatingActionButton(
             child: Icon(
               cubit.icon
             ) ,
             onPressed: (){
                  if(cubit.isBottomShow){
                    if(keyFrom.currentState!.validate()){

                      cubit.insertDataBase(
                          name: textController.text,
                          time: timeController.text,
                          datas: dateController.text,
                      ).then((value) {
                        cubit.showBottomSheet(
                          isShow: false,
                          icondata: Icons.edit,
                        );
                        Navigator.pop(context);

                      });

                  }

               }else{
                 scaffoldKey.currentState!.showBottomSheet((context) =>Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Form(
                     key: keyFrom,
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         TextFormField(
                           controller:textController ,
                           validator: (String? value){
                             if(value!.isEmpty){
                               return 'pleas enter Text';
                             }
                           },
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.text_fields),
                             border: OutlineInputBorder(),
                           ),
                         ),
                         SizedBox(height: 15.0,),
                         TextFormField(
                           keyboardType: TextInputType.none,
                           controller:timeController ,
                           validator: (String? value){
                             if(value!.isEmpty){
                               return 'pleas enter time';
                             }
                           },
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.watch_later_outlined),
                             border: OutlineInputBorder(),
                           ),
                           onTap: (){
                             showTimePicker(
                                 context: context,
                                 initialTime: TimeOfDay.now(),
                             ).then((value) {
                               timeController.text=value!.format(context).toString();
                             });
                           },
                         ),
                         SizedBox(height: 15.0,),
                         TextFormField(
                           keyboardType: TextInputType.none,
                           controller: dateController ,
                           validator: (String? value){
                             if(value!.isEmpty){
                               return 'pleas enter date';
                             }
                           },
                           decoration: InputDecoration(
                             prefixIcon: Icon(Icons.date_range_outlined),
                             border: OutlineInputBorder(),
                           ),
                           onTap: (){
                             showDatePicker(
                                 context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime.now(),
                                 lastDate: DateTime.parse('2025-02-02'),
                             ).then((value) {
                               dateController.text=DateFormat.yMMMd().format(value!);
                             });
                           },
                         ),
                       ],
                     ),
                   ),
                 )).closed.then((value) {
                   cubit.showBottomSheet(
                       isShow: false,
                       icondata: Icons.edit,
                   );
                 });
                 cubit.showBottomSheet(
                   isShow: true,
                   icondata: Icons.add,
                 );
               }



             },
           ),
           bottomNavigationBar:BottomNavigationBar(

             items: cubit.bottom,
             onTap: (index){
               cubit.changeBottom(indexs: index);
             },
             currentIndex: cubit.index,
           ) ,
          );
        }
      ),
    );
  }
}
