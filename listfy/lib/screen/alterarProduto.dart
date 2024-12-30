import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/util/uteis.dart';
import 'package:provider/provider.dart';

class AlterarProduto extends StatefulWidget {
  const AlterarProduto(
      {super.key, required this.produto, required this.produtoContext});
//Aqui eu entendi que eu estou criando um context e tornando ele de certa forma obrigatório

  final BuildContext produtoContext;
  final ProdutoModel produto;

  @override
  State<AlterarProduto> createState() => _AlterarProdutoState();
}

class _AlterarProdutoState extends State<AlterarProduto> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _quantidadeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validar(String? valor) {
    if (valor != null && valor.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.produto.nome);
    _valorController =
        TextEditingController(text: widget.produto.valor.toString());
    _quantidadeController =
        TextEditingController(text: widget.produto.quantidade.toString());
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _valorController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Alterar produto",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(widget.produto.nome,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _nomeController,
                    maxLength: 30,
                    validator: (String? value) {
                      if (validar(value)) {
                        return "Insira o nome do produto";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        label: Text("Nome do produto:"),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 7,
                    inputFormatters: [CustomNumberFormatter()],
                    controller: _valorController,
                    validator: (String? value) {
                      if (validar(value)) {
                        return "Insira o valor estimado do produto";
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
                    maxLength: 7,
                    inputFormatters: [CustomNumberFormatter()],
                    controller: _quantidadeController,
                    validator: (String? value) {
                      if (validar(value)) {
                        return "Insira a quantidade desejada";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        label: Text("Quantidade:"),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //pegando os valores do textField e aplicando uma formatação tirando espaços em branco
                          final id = widget.produto.id;
                          final nome = _nomeController.text.trim();
                          final valor = _valorController.text.trim();
                          final quantidade = _quantidadeController.text.trim();

                          final ProdutoModel produto = ProdutoModel(
                              id: id,
                              nome: nome,
                              valor: double.parse(valor),
                              quantidade: double.parse(quantidade));

                          await Provider.of<ProdutoProvider>(context,
                                  listen: false)
                              .alterarProduto(produto);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Produto Alterado com sucesso !'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Alterar",
                        style: TextStyle(fontSize: 17),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
