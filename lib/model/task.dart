import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totdo/shered/components/components.dart';
import 'package:totdo/shered/cubit/cubit.dart';
import 'package:totdo/shered/cubit/states.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitTodo,TotodStates>(
      listener: (context , state){},
      builder: (context,state) {
        var list=CubitTodo.get(context).task;
        return buildCondition(list);
      }
    );
  }
}