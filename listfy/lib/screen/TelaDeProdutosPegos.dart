import 'package:flutter/material.dart';
import 'package:listfy/components/opcoesProdutosPegos.dart';
import 'package:listfy/components/produtoPego.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
// import 'package:listfy/screen/somadores.dart';
import 'package:provider/provider.dart';

class TelaDeProdutosPegos extends StatefulWidget {
  const TelaDeProdutosPegos({super.key});

  @override
  State<TelaDeProdutosPegos> createState() => _TelaDeProdutosPegosState();
}

class _TelaDeProdutosPegosState extends State<TelaDeProdutosPegos> {
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
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

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
      body: Consumer<ProdutoProvider>(
        builder: (context, provider, child) {
          // Agrupar os produtos pela categoria
          final Map<String, List<ProdutoModel>> produtosPorCategoria = {};

          for (var produto in provider.produtosPegos) {
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
                return SizedBox(
                  height: size.width * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Previsão de valores no carrinho",
                            style: TextStyle(fontSize: 18)),
                        Row(
                          children: [
                            const Text(
                              "Total a Pagar: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              Provider.of<ProdutoProvider>(context,
                                      listen: false)
                                  .somarValoresCarrinho()
                                  .toStringAsFixed(2),
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
                              Provider.of<ProdutoProvider>(context,
                                      listen: false)
                                  .somarQuantidadeCarrinho()
                                  .toStringAsFixed(2),
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
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
                    return ProdutoPego(produto: produto);
                  }).toList(),
                );
              }
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (contextNew) => const Somadores()));
      //   },
      //   child: const Icon(Icons.check),
      // ),
    );
  }
}
