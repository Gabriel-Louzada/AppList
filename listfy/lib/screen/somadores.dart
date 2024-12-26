import 'package:flutter/material.dart';
import 'package:listfy/components/drawer.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:provider/provider.dart';

class Somadores extends StatefulWidget {
  const Somadores({super.key});

  @override
  State<Somadores> createState() => _SomadoresState();
}

class _SomadoresState extends State<Somadores> {
  List<ProdutoModel> produtos = [];

  double somarQuantidade(List<ProdutoModel> produtos) {
    double quantidadeTotal = 0;
    for (var produto in produtos) {
      quantidadeTotal += produto.quantidade;
    }
    return quantidadeTotal;
  }

  double somarValores(List<ProdutoModel> produtos) {
    double valorTotal = 0;
    for (var produto in produtos) {
      valorTotal += produto.valor;
    }
    return valorTotal;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false).carregarProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    double quantidadeTotal =
        Provider.of<ProdutoProvider>(context, listen: false).somarQuantidade();
    double valorTotal =
        Provider.of<ProdutoProvider>(context, listen: false).somarValores();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Totalizador",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      drawer: const MeuDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text(
                "Total a Pagar: ",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "$valorTotal",
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Total Volumes: ",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "$quantidadeTotal",
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
