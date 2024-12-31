import 'package:flutter/material.dart';
import 'package:listfy/components/produtoSelecao.dart';
import 'package:listfy/data/provider.dart';
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
          return ListView.builder(
            itemCount: provider.produtos.length + 1,
            itemBuilder: (context, index) {
              if (index == provider.produtos.length) {
                return const SizedBox(height: 80);
              } else {
                final produtoProvider = provider.produtos[index];
                return ProdutoSelecao(produto: produtoProvider);
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
                      "Deseja realmente remover todos os produtos selecionados?"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<ProdutoProvider>(context, listen: false)
                              .removerSelecionados();
                          Navigator.pop(context);
                        },
                        child: const Text("Confirmar"))
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
