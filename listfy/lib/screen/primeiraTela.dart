import 'package:flutter/material.dart';
import 'package:listfy/components/drawer.dart';
import 'package:listfy/components/opcoesProdutos.dart';
import 'package:listfy/components/produto.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/screen/TelaDeProdutosPegos.dart';
import 'package:provider/provider.dart';

class PrimeiraTela extends StatefulWidget {
  const PrimeiraTela({super.key});

  @override
  State<PrimeiraTela> createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  bool isChecked = false; //ESTADO INICIAL DO CHECKBOX

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProdutoProvider>(context, listen: false).carregarProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Lista de Compras",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: const [OpcoesProduto()],
      ),
      drawer: const MeuDrawer(),
      body: Consumer<ProdutoProvider>(
        builder: (context, provider, child) {
          // Agrupar os produtos pela categoria
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
                    return Produto(produto: produto);
                  }).toList(),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contextNew) => const TelaDeProdutosPegos()));
        },
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
