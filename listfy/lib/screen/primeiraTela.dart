import 'package:flutter/material.dart';
import 'package:listfy/components/drawer.dart';
import 'package:listfy/components/opcoesProdutos.dart';
import 'package:listfy/components/produto.dart';
import 'package:listfy/dao/ProdutoDao.dart';
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
  final Produtodao produtodao = Produtodao();
  List<ProdutoModel> produtos = [];
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
          return ListView.builder(
            itemCount: provider.produtos.length + 1,
            itemBuilder: (context, index) {
              if (index == provider.produtos.length) {
                return const SizedBox(height: 80);
              } else {
                final produtoProvider = provider.produtos[index];
                return Produto(produto: produtoProvider);
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
