import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/theme/app_theme.dart';
import 'package:listly/ui/ui_listas.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listly',
      theme: AppTheme.light(Color(0xFF2F5233)),
      debugShowCheckedModeBanner: true, //Cinta del debug
      home: const ListasPage(tituloPage: "Demo Listly"),
    );
  }
}

