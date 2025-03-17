import 'package:flutter/material.dart';
import 'package:listfy/dao/ProdutoDao.dart';
import 'package:listfy/models/produtoModels.dart';

class ProdutoProvider extends ChangeNotifier {
  //_Produto sera responsavel por produtos em que o ativo esta igual a false
  List<ProdutoModel> _produtos = [];
  List<ProdutoModel> _produtosPegos = [];
  List<ProdutoModel> _produtosDesativados = [];

  //SEMPRE QUE O CHECKBOX FOR SELECIONADO, EU IREI ADICIONAR UM PRODUTO A LISTA
  final List<ProdutoModel> _produtosSelecionados = [];

  List<ProdutoModel> get produtos => _produtos;
  List<ProdutoModel> get produtosPegos => _produtosPegos;
  List<ProdutoModel> get produtosDesativados => _produtosDesativados;
  List<ProdutoModel> get produtosSelecionados => _produtosSelecionados;

  //CARREGAR TODOS OS PRODUTOS
  Future<void> carregarProdutos() async {
    _produtos = await Produtodao().listarTodosProdutos();
    notifyListeners();
  }

  Future<void> carregarProdutosPegos() async {
    _produtosPegos = await Produtodao().listarTodosProdutosPegos();
    notifyListeners();
  }

  Future<void> carregarProdutosDesativados() async {
    _produtosDesativados = await Produtodao().listarTodosProdutosDesativados();
    notifyListeners();
  }

//SELECIONAR VARIOS PRODUTOS PARA REMOVER
  void selecionarProduto(ProdutoModel produto, isChecked) {
    if (isChecked) {
      if (!_produtosSelecionados.contains(produto)) {
        _produtosSelecionados.add(produto);
      }
    } else {
      _produtosSelecionados.remove(produto);
    }
    notifyListeners();
  }

//MARCAR OU DESMARCAR TODOS OS PRODUTOS
  void selecionarTodosProdutos() {
    for (var produto in _produtos) {
      if (produto.isChecked != true) {
        produto.isChecked = true;
        selecionarProduto(produto, true);
      } else {
        produto.isChecked = false;
        selecionarProduto(produto, false);
      }
    }
    notifyListeners();
  }

//REMOVER VARIOS PRODUTOS
  Future<void> removerSelecionados() async {
    for (var produto in produtosSelecionados) {
      if (produto.isChecked) {
        await Produtodao().removerProduto(produto.id!);
      }
    }
    produtosSelecionados.clear();
    resetarSelecao();
    carregarProdutos();
  }

  Future<void> desativarSelecionados() async {
    for (var produto in produtosSelecionados) {
      if (produto.isChecked) {
        await Produtodao().desativarProduto(produto.id!);
      }
    }
    produtosSelecionados.clear();
    resetarSelecao();
    carregarProdutos();
  }

//GARANTO QUE TODOS OS PRODUTOS FIQUEM COM O CHECKBOX DESMARCADO
  void resetarSelecao() {
    for (var produto in _produtos) {
      produto.isChecked = false;
    }
    carregarProdutos();
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
    carregarProdutosDesativados();
    carregarProdutosPegos();
  }

//Posso pegar os dois tipos de produtos
  Future<void> pegarProduto(ProdutoModel produto) async {
    await Produtodao().pegarProduto(produto);
    carregarProdutos();
    carregarProdutosPegos();
  }

//Posso pegar os dois tipos de produtos
  Future<void> voltaLista(ProdutoModel produto) async {
    await Produtodao().voltaLista(produto);
    carregarProdutos();
    carregarProdutosPegos();
  }

//Posso remover os dois tipos de produtos
  Future<void> removerProduto(int id) async {
    await Produtodao().removerProduto(id);
    carregarProdutos();
    carregarProdutosDesativados();
    carregarProdutosPegos();
  }

  double somarQuantidadeCarrinho() {
    double quantidadeTotal = 0;
    for (var produto in produtosPegos) {
      print("********************");
      print(produto);
      quantidadeTotal += produto.quantidade;
    }
    return quantidadeTotal;
  }

  double somarValoresCarrinho() {
    double valorTotal = 0;
    for (var produto in produtosPegos) {
      print("********************");
      print(produto);
      valorTotal += (produto.valor * produto.quantidade);
    }
    return valorTotal;
  }

  double somarQuantidadeList() {
    double quantidadeTotal = 0;
    for (var produto in produtos) {
      quantidadeTotal += produto.quantidade;
    }
    return quantidadeTotal;
  }

  double somarValoresList() {
    double valorTotal = 0;
    for (var produto in produtos) {
      valorTotal += (produto.valor * produto.quantidade);
    }
    return valorTotal;
  }

//PEGAR TODOS OS PRODUTOS
  Future<void> pegarTodosProdutos() async {
    await Produtodao().pegarTodosProdutos();
    carregarProdutos();
    carregarProdutosPegos();
  }

//VOLTAR TODOS OS PRODUTOS PARA A LISTA
  Future<void> voltaListaTodos() async {
    await Produtodao().voltarListaTodos();
    carregarProdutos();
    carregarProdutosPegos();
  }

  ativarProduto(ProdutoModel produto) async {
    await Produtodao().ativarProduto(produto);
    carregarProdutos();
    carregarProdutosPegos();
    carregarProdutosDesativados();
  }
}
