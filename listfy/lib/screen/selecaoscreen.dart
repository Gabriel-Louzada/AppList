import 'package:flutter/material.dart';
import 'package:listfy/components/produtoSelecao.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:provider/provider.dart';

class SelecaoScreen extends StatefulWidget {
  const SelecaoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelecaoScreenState createState() => _SelecaoScreenState();
}

class _SelecaoScreenState extends State<SelecaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Seleção de produtos",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ProdutoProvider>(context, listen: false)
                    .selecionarTodosProdutos();
              },
              icon: const Icon(Icons.library_add_check_outlined))
        ],
      ),
      body: Consumer<ProdutoProvider>(
        builder: (context, provider, child) {
          final Map<String, List<ProdutoModel>> produtosPorCategoria = {};

          for (var produto in provider.produtos) {
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
                    return ProdutoSelecao(produto: produto);
                  }).toList(),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Atenção!"),
                  content: const Text(
                      "Deseja desativar ou remover todos os produtos. Para abortar pressione fora da caixa "),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<ProdutoProvider>(context, listen: false)
                              .removerSelecionados();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Remover",
                          style: TextStyle(color: Colors.red),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<ProdutoProvider>(context, listen: false)
                              .desativarSelecionados();
                          Navigator.pop(context);
                        },
                        child: const Text("Desativar")),
                  ],
                );
              });
        },
        backgroundColor: const Color.fromARGB(153, 251, 66, 66),
        child: const Icon(Icons.remove_shopping_cart),
      ),
    );
  }
}
