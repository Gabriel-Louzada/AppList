import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/models/produtoModels.dart';
import 'package:listfy/util/uteis.dart';
import 'package:provider/provider.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key, required this.produtoContext});

  final BuildContext produtoContext;

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final imagePicker = ImagePicker();
  File? imageFile;
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

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Imagem vinculada com sucesso !")),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nem uma imagem foi selecionada")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text("ListFy",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text("Adicionar Produto a lista",
                      style: TextStyle(fontSize: 18)),
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
                    // ESSE CARA FARÁ A TRATATIVA DOS VALORES INSERIDOS
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
                    // ESSE CARA FARÁ A TRATATIVA DOS VALORES INSERIDOS
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
                    height: 15,
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
                              0.25, // Metade da tela
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text(
                                  "Galeria",
                                  style: TextStyle(fontSize: 25),
                                ),
                                onTap: () {
                                  pick(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text(
                                  "Camera",
                                  style: TextStyle(fontSize: 25),
                                ),
                                onTap: () {
                                  pick(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: const Text("Vincular imagem",
                        style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //pegando os valores do textField e aplicando uma formatação tirando espaços em branco
                          final nome = _nomeController.text.trim();
                          final valor = _valorController.text.trim();
                          final quantidade = _quantidadeController.text.trim();
                          final File imagem = imageFile != null
                              ? File(imageFile!.path)
                              : File("assets/icone_app.png");

                          final ProdutoModel produto = ProdutoModel(
                              nome: nome,
                              valor: double.parse(valor),
                              quantidade: double.parse(quantidade),
                              imagem: imagem.path.toString());

                          await Provider.of<ProdutoProvider>(context,
                                  listen: false)
                              .adicionarProduto(produto);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Produto adicionado a lista com sucesso'),
                            ),
                          );

                          //LIMPANDO OS CAMPOS
                          _nomeController.clear();
                          _valorController.clear();
                          _quantidadeController.clear();
                          setState(() {
                            imageFile = null;
                          });
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
        ],
      ),
    );
  }
}
