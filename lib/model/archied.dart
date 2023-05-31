import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totdo/shered/components/components.dart';
import 'package:totdo/shered/cubit/cubit.dart';
import 'package:totdo/shered/cubit/states.dart';

class Archive extends StatelessWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitTodo,TotodStates>(
        listener: (context , state){},
        builder: (context,state) {
          var list=CubitTodo.get(context).archie;
          return buildCondition(list);
        }
    );
  }
}
