import 'package:flutter/material.dart';
import 'package:listfy/components/drawer.dart';
import 'package:listfy/components/produto.dart';
import 'package:listfy/dao/ProdutoDao.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/screen/tela_cadastro.dart';

class PrimeiraTela extends StatefulWidget {
  const PrimeiraTela({super.key});

  @override
  State<PrimeiraTela> createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  final Produtodao produtodao = Produtodao();
  List<ProdutoModel> produtos = [];
  bool isChecked = false; //ESTADO INICIAL DO CHECKBOX

  @override
  void initState() {
    super.initState();
    carregarProduto();
  }

  void carregarProduto() async {
    final lista = await produtodao.listarTodosProdutos();
    setState(() {
      produtos = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "ListFy",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                carregarProduto();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      drawer: const MeuDrawer(),
      body: produtos.isEmpty
          ? const Center(
              child: Text(
                "Nenhum produto cadastrado",
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return Produto(
                  produto: produto,
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contextNew) =>
                      TelaCadastro(produtoContext: contextNew)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
