import 'package:flutter/material.dart';
import 'package:listfy/components/opcoesProdutosPegos.dart';
import 'package:listfy/components/produtoPego.dart';
import 'package:listfy/dao/ProdutoDao.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/screen/somadores.dart';
import 'package:provider/provider.dart';

class TelaDeProdutosPegos extends StatefulWidget {
  const TelaDeProdutosPegos({super.key});

  @override
  State<TelaDeProdutosPegos> createState() => _TelaDeProdutosPegosState();
}

class _TelaDeProdutosPegosState extends State<TelaDeProdutosPegos> {
  final Produtodao produtodao = Produtodao();
  List<ProdutoModel> produtos = [];
  bool isChecked = false; //ESTADO INICIAL DO CHECKBOX

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false)
          .carregarProdutosPegos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Carrinho",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: const [OpcoesProdutoPegos()],
      ),
      body: Consumer<ProdutoProvider>(builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.produtosPegos.length + 1,
          itemBuilder: (context, index) {
            if (index == provider.produtosPegos.length) {
              return const SizedBox(height: 80);
            } else {
              final produtoProvider = provider.produtosPegos[index];
              return ProdutoPego(produto: produtoProvider);
            }
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (contextNew) => const Somadores()));
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
