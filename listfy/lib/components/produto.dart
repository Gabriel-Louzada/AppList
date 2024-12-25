import 'package:flutter/material.dart';
import 'package:listfy/dao/ProdutoDao.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/screen/alterarProduto.dart';
import 'package:provider/provider.dart';

// AQUI EU TENHO UMA CLASSE PRODUTO OU SEJA UM CARD
enum SampleItem { itemUm, itemDois }

class Produto extends StatefulWidget {
// criando parametros para essa classe

  final ProdutoModel produto;

// coloco essas variaveis no metodo construtor ?
  const Produto({required this.produto, super.key});

  @override
  State<Produto> createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  bool isPego = false;
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Stack(
            //alignment: AlignmentDirectional.center,
            children: [
              Container(
                //Esse pode ser o considerado o container pai
                decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 94, 93, 93),
                    borderRadius: BorderRadius.circular(4)),
                width: 500,
                height: 120,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12,
                    ),
                    width: 100,
                    height: 120,
                    child: const Text(
                      "Imagem do Produto",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 270,
                        child: SizedBox(
                            child: Text(widget.produto.nome,
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600))),
                      ),
                      Text(
                        "Valor:  ${widget.produto.valor} Qtde: ${widget.produto.quantidade}",
                        style: const TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Switch(
                          value: isPego,
                          activeColor: Colors.redAccent,
                          onChanged: (bool value) async {
                            setState(() {
                              isPego = value;
                            });
                            //chamando a função para mudar o produto de lugar em tela
                            ProdutoModel produtoAlterado = ProdutoModel(
                              id: widget.produto.id,
                              nome: widget.produto.nome,
                              valor: widget.produto.valor,
                              quantidade: widget.produto.quantidade,
                            );
                            await Produtodao().pegarProduto(produtoAlterado);
                          }),
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
          )
        ],
      ),
    );
  }
}
