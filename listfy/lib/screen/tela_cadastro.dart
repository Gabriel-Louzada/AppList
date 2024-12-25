import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:provider/provider.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key, required this.produtoContext});

  final BuildContext produtoContext;

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validar(String? valor) {
    if (valor != null && valor.isEmpty) {
      return true;
    } else {
      return false;
    }
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
        backgroundColor: Colors.blueAccent,
        title: const Text("Cadastro de produtos",
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Adicionar Produtos a lista",
                  style: TextStyle(fontSize: 25)),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _nomeController,
                maxLength: 35,
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
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 5,
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
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 5,
                controller: _quantidadeController,
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
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //pegando os valores do textField e aplicando uma formatação tirando espaços em branco
                      final nome = _nomeController.text.trim();
                      final valor = _valorController.text.trim();
                      final quantidade = _quantidadeController.text.trim();

                      final ProdutoModel produto = ProdutoModel(
                          nome: nome,
                          valor: double.parse(valor),
                          quantidade: double.parse(quantidade));

                      await Provider.of<ProdutoProvider>(context, listen: false)
                          .adicionarProduto(produto);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Produto adicionado a lista com sucesso ! '),
                        ),
                      );

                      //LIMPANDO OS CAMPOS
                      _nomeController.clear();
                      _valorController.clear();
                      _quantidadeController.clear();
                    }
                  },
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(fontSize: 17),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
