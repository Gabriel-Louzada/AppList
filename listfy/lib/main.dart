import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/screen/primeiraTela.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProdutoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Listfy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const PrimeiraTela(),
      ),
    );
  }
}
