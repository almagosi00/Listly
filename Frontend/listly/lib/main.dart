import 'package:flutter/material.dart';
import 'package:listly/theme/app_theme.dart';
import 'package:listly/ui/ui_listas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listly',
      theme: AppTheme.light,
  debugShowCheckedModeBanner: true, //Cinta del debug
      home: const ListasPage(tituloPage: "Demo Listly"),
    );
  }
}

