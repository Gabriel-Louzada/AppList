import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:provider/provider.dart';

// AQUI EU TENHO UMA CLASSE PRODUTO OU SEJA UM CARD
enum SampleItem { itemUm, itemDois }

class ProdutoSelecao extends StatefulWidget {
  final ProdutoModel produto;
  const ProdutoSelecao({required this.produto, super.key});

  @override
  State<ProdutoSelecao> createState() => _ProdutoState();
}

class _ProdutoState extends State<ProdutoSelecao> {
  List<ProdutoModel> produtosSelecionados = [];
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
                      SizedBox(
                        width: 0.020 * size.width,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              title: Text(
                                widget.produto.nome,
                                style: TextStyle(
                                  fontSize: 0.045 * size.width,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: widget.produto.isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.produto.isChecked = value!;
                                  Provider.of<ProdutoProvider>(context,
                                          listen: false)
                                      .selecionarProduto(widget.produto,
                                          widget.produto.isChecked);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
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
