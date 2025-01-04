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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false).carregarProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    double quantidadeTotalCarrinho =
        Provider.of<ProdutoProvider>(context, listen: false)
            .somarQuantidadeCarrinho();
    double valorTotalCarrinho =
        Provider.of<ProdutoProvider>(context, listen: false)
            .somarValoresCarrinho();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Totalizador",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      drawer: const MeuDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Column(
                  children: [
                    Text(
                      "Pontos Importantes a se observar",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                        " 1° Essa pagina serve para mostrar o total de todos os produtos que você já adicionou no carrinho, Mas é apenas um previsão pois tem produtos pesaveis que o valor correto só aparecerá no caixa"),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.30,
                ),
                Column(
                  children: [
                    const Text("Previsão de valores no carrinho",
                        style: TextStyle(fontSize: 18)),
                    Row(
                      children: [
                        const Text(
                          "Total a Pagar: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          valorTotalCarrinho.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Total Volumes: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          quantidadeTotalCarrinho.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
