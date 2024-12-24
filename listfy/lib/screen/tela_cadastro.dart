import 'package:flutter/material.dart';
import 'package:listfy/dao/ProdutoDao.dart';
//import 'package:listfy/data/produto_inherited.dart';
import 'package:listfy/models/produtoModels.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key, required this.produtoContext});
//Aqui eu entendi que eu estou criando um context e tornando ele de certa forma obrigatório

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
  Widget build(BuildContext context) {
    //meusProdutos = Provider.of<ProdutoProvider>(context);
    //final valorTotal = ProdutoInherited.of(context).somaValores();
    //final quantidadeTotal = ProdutoInherited.of(context).somaQuantidades();

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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //pegando os valores do textField e aplicando uma formatação tirando espaços em branco
                      final nome = _nomeController.text.trim();
                      final valor = _valorController.text.trim();
                      final quantidade = _quantidadeController.text.trim();

                      final ProdutoModel produto = ProdutoModel(
                          nome: nome,
                          valor: double.parse(valor),
                          quantidade: double.parse(quantidade));

                      print(produto);

                      Produtodao().inserirProduto(produto);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Adicionando um produto a lista '),
                        ),
                      );
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
