import 'package:flutter/material.dart';
import 'package:listfy/dao/ProdutoDao.dart';
import 'package:listfy/models/produtoModels.dart';

class ProdutoProvider extends ChangeNotifier {
  //_Produto sera responsavel por produtos em que o ativo esta igual a false
  List<ProdutoModel> _produtos = [];
  List<ProdutoModel> _produtosPegos = [];

  List<ProdutoModel> get produtos => _produtos;
  List<ProdutoModel> get produtosPegos => _produtosPegos;

  //CARREGAR TODOS OS PRODUTOS
  Future<void> carregarProdutos() async {
    _produtos = await Produtodao().listarTodosProdutos();
    print("Produtos sem pegar");
    print(_produtos);
    notifyListeners();
  }

  Future<void> carregarProdutosPegos() async {
    _produtosPegos = await Produtodao().listarTodosProdutosPegos();
    print("Produtos pegos");
    print(_produtosPegos);
    notifyListeners();
  }

  Future<void> adicionarProduto(ProdutoModel produto) async {
    await Produtodao().inserirProduto(produto);
    carregarProdutos();
  }

  // ADICIONA PRODUTO PADRÃO
  Future<void> adicionarProdutopadrao() async {
    await Produtodao().inserirProdutoPadrao();
    carregarProdutos();
  }

  Future<void> alterarProduto(ProdutoModel produto) async {
    await Produtodao().alterarProduto(produto);
    carregarProdutos();
    carregarProdutosPegos();
  }

//Posso pegar os dois tipos de produtos
  Future<void> pegarProduto(ProdutoModel produto) async {
    await Produtodao().pegarProduto(produto);
    carregarProdutos();
    carregarProdutosPegos();
  }

//Posso pegar os dois tipos de produtos
  Future<void> voltarCarrinho(ProdutoModel produto) async {
    await Produtodao().voltarCarrinho(produto);
    carregarProdutos();
    carregarProdutosPegos();
  }

//Posso remover os dois tipos de produtos
  Future<void> removerProduto(int id) async {
    await Produtodao().removerProduto(id);
    carregarProdutos();
    carregarProdutosPegos();
  }

  double somarQuantidade() {
    double quantidadeTotal = 0;
    for (var produto in produtos) {
      quantidadeTotal += produto.quantidade;
    }
    return quantidadeTotal;
  }

  double somarValores() {
    double valorTotal = 0;
    for (var produto in _produtos) {
      valorTotal += (produto.valor * produto.quantidade);
    }
    return valorTotal;
  }
}
