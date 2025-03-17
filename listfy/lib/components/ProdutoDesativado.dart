import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/screen/alterarProduto.dart';
import 'package:provider/provider.dart';

// AQUI EU TENHO UMA CLASSE PRODUTO OU SEJA UM CARD
enum SampleItem { itemUm, itemDois }

class ProdutoDesativado extends StatefulWidget {
  final ProdutoModel produto;
  const ProdutoDesativado({required this.produto, super.key});

  @override
  State<ProdutoDesativado> createState() => _ProdutoState();
}

class _ProdutoState extends State<ProdutoDesativado> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Column(
      children: [
        const SizedBox(
          height: 13,
        ),
        Center(
          child: Card(
            elevation: 8,
            child: Container(
              width: size.width * 0.95, // Defina um tamanho fixo para o card
              height: size.width * 0.27, // Altura do card
              alignment: Alignment.center, // Garante centralização
              //color: Colors.black26,
              child: Stack(
                children: [
                  Container(
                    // Container pai do card
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(31, 94, 93, 93),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: size.width,
                    height: size.height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black12,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: widget.produto.imagem != null &&
                                        widget.produto.imagem !=
                                            "assets/icone_app.png"
                                    ? FileImage(File(widget.produto.imagem!))
                                    : const AssetImage(
                                        "assets/icone_app.png"))),
                        width: size.width * 0.22,
                        height: size.height,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.produto.nome,
                              style: TextStyle(
                                fontSize: 0.045 * size.width,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Valor: ${widget.produto.valor} Qtde: ${widget.produto.quantidade}",
                              style: TextStyle(fontSize: 0.036 * size.width),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () async {
                                ProdutoModel produto = ProdutoModel(
                                  id: widget.produto.id,
                                  nome: widget.produto.nome,
                                  valor: widget.produto.valor,
                                  quantidade: widget.produto.quantidade,
                                  categoria: widget.produto.categoria,
                                );
                                await Provider.of<ProdutoProvider>(context,
                                        listen: false)
                                    .ativarProduto(produto);
                              },
                              icon: const Icon(Icons.check)),
                          PopupMenuButton<SampleItem>(
                            initialValue: selectedItem,
                            onSelected: (SampleItem item) {
                              setState(() {
                                selectedItem = item;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SampleItem>>[
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemDois,
                                child: const Text('Alterar'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contextNew) => AlterarProduto(
                                        produto: widget.produto,
                                        produtoContext: contextNew,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemUm,
                                child: const Text('Remover'),
                                onTap: () async {
                                  await Provider.of<ProdutoProvider>(context,
                                          listen: false)
                                      .removerProduto(widget.produto.id!);
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
