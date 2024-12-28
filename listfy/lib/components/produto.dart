import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/screen/alterarProduto.dart';
import 'package:provider/provider.dart';

// AQUI EU TENHO UMA CLASSE PRODUTO OU SEJA UM CARD
enum SampleItem { itemUm, itemDois }

class Produto extends StatefulWidget {
  final ProdutoModel produto;
  const Produto({required this.produto, super.key});

  @override
  State<Produto> createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
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
                      ),
                      width: size.width * 0.22,
                      height: size.height,
                      child: Text(
                        "Imagem do Produto",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.040 * size.width,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.020 * size.width,
                    ),
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
                            style: TextStyle(fontSize: 0.035 * size.width),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () async {
                            ProdutoModel produto = ProdutoModel(
                              id: widget.produto.id,
                              nome: widget.produto.nome,
                              valor: widget.produto.valor,
                              quantidade: widget.produto.quantidade,
                            );
                            meuDialog(context, produto);
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                        ),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool validar(String? valor) {
    if (valor != null && valor.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void meuDialog(BuildContext context, ProdutoModel produto) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    final formKey = GlobalKey<FormState>();
    TextEditingController valorController =
        TextEditingController(text: produto.valor.toString());
    TextEditingController quantidadeController =
        TextEditingController(text: produto.quantidade.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirme valor e quantidade do produto: ${produto.nome}",
            style: TextStyle(
              fontSize: size.width * 0.05,
            ),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  controller: valorController,
                  validator: (String? value) {
                    if (validar(value)) {
                      return "Insira o valor do produto";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text("Valor do produto:"),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  controller: quantidadeController,
                  validator: (String? value) {
                    if (validar(value)) {
                      return "Insira a quantidade desejada";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text("Quantidade:"), border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                //CANCELAR
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar",
                        style: TextStyle(color: Colors.red))),
                //ADICIONAR O CARRINHO
                ElevatedButton(
                  onPressed: () async {
                    //CRIO O PRODUTO
                    final id = produto.id;
                    final nome = produto.nome;
                    final valor = valorController.text.trim();
                    final quantidade = quantidadeController.text.trim();
                    final ProdutoModel produtoAlterado = ProdutoModel(
                      id: id,
                      nome: nome,
                      valor: double.parse(valor),
                      quantidade: double.parse(quantidade),
                    );
                    //ALTERO O PRODUTO
                    await Provider.of<ProdutoProvider>(context, listen: false)
                        .alterarProduto(produtoAlterado);
                    // ADICIONO O PRODUTO AO CARRINHO COM OS VALORES E QUANTIDADES CORRETAS
                    await Provider.of<ProdutoProvider>(context, listen: false)
                        .pegarProduto(produto);
                    //FECHAR A TELA
                    Navigator.pop(context);
                  },
                  child: const Text("Add Carrinho"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
