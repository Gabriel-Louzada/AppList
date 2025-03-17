import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/util/uteis.dart';
import 'package:listfy/util/vincularImagem.dart';
import 'package:provider/provider.dart';

class AlterarProduto extends StatefulWidget {
  final BuildContext produtoContext;
  final ProdutoModel produto;

  const AlterarProduto(
      {super.key, required this.produto, required this.produtoContext});

  @override
  State<AlterarProduto> createState() => _AlterarProdutoState();
}

class _AlterarProdutoState extends State<AlterarProduto> {
  late bool isPego;
  late bool isAtivo;
  File? imagem;
  File? novaImagem;
  String? _opcaoSelecionada;
  final File imagemPadrao = File("assets/icone_app.png");
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

  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.check),
      WidgetState.any: Icon(Icons.close),
    },
  );

  int validaPego(isPego) {
    if (isPego == false) {
      return 0;
    } else {
      return 1;
    }
  }

  int validaAtivo(isAtivo) {
    if (isAtivo == false) {
      return 0;
    } else {
      return 1;
    }
  }

  bool isPegoBd(int? pegoBd) {
    if (pegoBd == 0) {
      return false;
    } else {
      return true;
    }
  }

  bool isAtivoBd(int? ativoBd) {
    if (ativoBd == 0) {
      return false;
    } else {
      return true;
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
    imagem = File(widget.produto.imagem!.toString());
    novaImagem = imagem;
    isPego = isPegoBd(widget.produto.pego);
    isAtivo = isAtivoBd(widget.produto.isAtivo);
    _opcaoSelecionada = widget.produto.categoria!;
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
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
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
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Selecione a Categoria",
                      border: OutlineInputBorder(),
                    ),
                    value: _opcaoSelecionada,
                    items: const [
                      DropdownMenuItem(
                          value: 'Mercearia', child: Text('Mercearia')),
                      DropdownMenuItem(
                          value: 'Hortifrúti', child: Text('Hortifrúti')),
                      DropdownMenuItem(value: 'Carnes', child: Text('Carnes')),
                      DropdownMenuItem(
                          value: 'Frios e laticínios',
                          child: Text('Frios e laticínios')),
                      DropdownMenuItem(
                          value: 'Limpesa e Higiene Pessoal',
                          child: Text('Limpesa e Higiene Pessoal')),
                      DropdownMenuItem(value: 'Geral', child: Text('Geral')),
                    ],
                    onChanged: (String? novoValor) {
                      setState(() {
                        _opcaoSelecionada = novoValor;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione uma opção';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 22,
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
                    height: 10,
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "O produto já esta no carrinho?",
                        style: TextStyle(fontSize: 18),
                      ),
                      Switch(
                        thumbIcon: thumbIcon,
                        value: isPego,
                        onChanged: (bool value) {
                          setState(() {
                            isPego = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Produto Ativo?",
                        style: TextStyle(fontSize: 18),
                      ),
                      Switch(
                        thumbIcon: thumbIcon,
                        value: isAtivo,
                        onChanged: (bool value) {
                          setState(() {
                            isAtivo = value;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_a_photo),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // Permite ocupar mais espaço
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(8),
                          height: MediaQuery.of(context).size.height *
                              0.3, // Metade da tela
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text(
                                  "Galeria",
                                  style: TextStyle(fontSize: 25),
                                ),
                                onTap: () async {
                                  final imagemSelecionada =
                                      await VincularImagem()
                                          .pick(ImageSource.gallery);
                                  if (imagemSelecionada != null) {
                                    setState(() {
                                      novaImagem = imagemSelecionada;
                                    });
                                  } else {
                                    novaImagem = imagem;
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Nova imagem Vinculada com sucesso !'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text(
                                  "Camera",
                                  style: TextStyle(fontSize: 25),
                                ),
                                onTap: () async {
                                  final imagemSelecionada =
                                      await VincularImagem()
                                          .pick(ImageSource.camera);
                                  if (imagemSelecionada != null) {
                                    setState(() {
                                      novaImagem = imagemSelecionada;
                                    });
                                  } else {
                                    novaImagem = imagem;
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Nova imagem Vinculada com sucesso !'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text(
                                  "Remover imagem",
                                  style: TextStyle(fontSize: 25),
                                ),
                                onTap: () {
                                  setState(() {
                                    novaImagem = imagemPadrao;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Imagem removida !'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    title: const Text("Vincular imagem",
                        style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.42,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: const Border(
                            top: BorderSide(color: Colors.black12, width: 3.5),
                            bottom:
                                BorderSide(color: Colors.black12, width: 3.5),
                            left: BorderSide(color: Colors.black12, width: 3.5),
                            right:
                                BorderSide(color: Colors.black12, width: 3.5)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: novaImagem == null ||
                                    novaImagem!.path == imagemPadrao.path
                                ? AssetImage(imagemPadrao.path)
                                : FileImage(novaImagem!))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //pegando os valores do textField e aplicando uma formatação tirando espaços em branco
                          final id = widget.produto.id;
                          final nome = _nomeController.text.trim();
                          final valor = _valorController.text.trim();
                          final quantidade = _quantidadeController.text.trim();
                          final categoria = _opcaoSelecionada;

                          final ProdutoModel produto = ProdutoModel(
                              id: id,
                              nome: nome,
                              valor: double.parse(valor),
                              quantidade: double.parse(quantidade),
                              pego: validaPego(isPego),
                              imagem: novaImagem == null
                                  ? imagem!.path
                                  : novaImagem!.path,
                              categoria: categoria,
                              isAtivo: validaAtivo(isAtivo));

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
