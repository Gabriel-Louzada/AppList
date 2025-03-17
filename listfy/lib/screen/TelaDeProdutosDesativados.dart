import 'package:flutter/material.dart';
import 'package:listfy/components/ProdutoDesativado.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:provider/provider.dart';

class TelaDeProdutosDesativados extends StatefulWidget {
  const TelaDeProdutosDesativados({super.key});

  @override
  State<TelaDeProdutosDesativados> createState() =>
      _TelaDeProdutosDesativadosState();
}

class _TelaDeProdutosDesativadosState extends State<TelaDeProdutosDesativados> {
  bool isChecked = false; //ESTADO INICIAL DO CHECKBOX

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false)
          .carregarProdutosDesativados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Produtos Desativados",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Consumer<ProdutoProvider>(
        builder: (context, provider, child) {
          // Agrupar os produtos pela categoria
          final Map<String, List<ProdutoModel>> produtosPorCategoria = {};

          for (var produto in provider.produtosDesativados) {
            if (!produtosPorCategoria.containsKey(produto.categoria)) {
              produtosPorCategoria[produto.categoria!] = [];
            }
            produtosPorCategoria[produto.categoria]!.add(produto);
          }

          // Lista de categorias (chaves do mapa)
          final categorias = produtosPorCategoria.keys.toList();

          return ListView.builder(
            itemCount: categorias.length + 1,
            itemBuilder: (context, index) {
              if (index == categorias.length) {
                return const SizedBox(height: 80);
              } else {
                final categoria = categorias[index];
                final produtos = produtosPorCategoria[categoria]!;
                return ExpansionTile(
                  maintainState: true,
                  childrenPadding: const EdgeInsets.only(bottom: 20),
                  collapsedBackgroundColor:
                      Colors.transparent, // Remove a aparência do fundo
                  backgroundColor:
                      Colors.transparent, // Define o fundo como transparente
                  title: Text(
                    categoria,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  children: produtos.map((produto) {
                    return ProdutoDesativado(produto: produto);
                  }).toList(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
