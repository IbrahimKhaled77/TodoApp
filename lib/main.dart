import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totdo/Layout/layout.dart';
import 'package:totdo/shered/blocobserve/blocobserve.dart';

void main() {
  Bloc.observer= const SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutTodot(),
    );
  }
}
