import 'package:flutter/material.dart';
import 'package:listfy/components/drawer.dart';
import 'package:listfy/components/produtoPego.dart';
import 'package:listfy/dao/ProdutoDao.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/screen/tela_cadastro.dart';
import 'package:provider/provider.dart';

class TelaDeProdutosPegos extends StatefulWidget {
  const TelaDeProdutosPegos({super.key});

  @override
  State<TelaDeProdutosPegos> createState() => _TelaDeProdutosPegosState();
}

class _TelaDeProdutosPegosState extends State<TelaDeProdutosPegos> {
  final Produtodao produtodao = Produtodao();
  List<ProdutoModel> produtos = [];
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Carrinho",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      drawer: const MeuDrawer(),
      body: Consumer<ProdutoProvider>(builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.produtosPegos.length,
          itemBuilder: (context, index) {
            final produtoProvider = provider.produtosPegos[index];
            return ProdutoPego(produto: produtoProvider);
          },
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
