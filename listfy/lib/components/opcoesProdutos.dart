import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/screen/selecaoscreen.dart';
import 'package:listfy/screen/tela_cadastro.dart';
import 'package:provider/provider.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class OpcoesProduto extends StatefulWidget {
  const OpcoesProduto({super.key});

  @override
  State<OpcoesProduto> createState() => _OpcoesProdutoState();
}

class _OpcoesProdutoState extends State<OpcoesProduto> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_horiz),
          tooltip: 'Show menu',
        );
      },
      menuChildren: [
        ListTile(
          leading: const Icon(Icons.add_box_outlined),
          title: const Text('Cadastrar Produto'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contextNew) =>
                        TelaCadastro(produtoContext: contextNew)));
          },
        ),
        ListTile(
          leading: const Icon(Icons.library_add_check_outlined),
          title: const Text("Selecionar Varios"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SelecaoScreen();
            }));
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_shopping_cart_sharp),
          title: const Text("Add todos ao carrinho"),
          onTap: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Atenção!"),
                    content: const Text(
                        "Deseja realmente adicionar todos os produtos da lista ao carrinho, sem conferir valores e quantidades ?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.red),
                          )),
                      ElevatedButton(
                          onPressed: () async {
                            await Provider.of<ProdutoProvider>(context,
                                    listen: false)
                                .pegarTodosProdutos();
                            Navigator.pop(context);
                          },
                          child: const Text("Continuar"))
                    ],
                  );
                });
          },
        )
      ],
    );
  }
}
