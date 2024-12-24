import 'package:flutter/material.dart';
import 'package:listfy/screen/primeiraTela.dart';

void main() {
  //Nunca esqueça de que o Inherited deve ser o primeiro item da árvore de widget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listfy',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.amber),
      home: const PrimeiraTela(),
    );
  }
}
