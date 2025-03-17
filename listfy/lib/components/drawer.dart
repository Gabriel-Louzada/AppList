import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/screen/somadores.dart';
import 'package:provider/provider.dart';

class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ListFy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Seu App para lista de compras',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Totalizadores'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contextNew) => const Somadores()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_add),
            title: const Text('Add Cesta Completa'),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                          "Deseja realmente adicionar os produtos padrões a lista ?"),
                      content: const Text(
                          "Essa função é utilzada para ganhar tempo no cadastro da lista"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                await Provider.of<ProdutoProvider>(context,
                                        listen: false)
                                    .adicionarProdutopadrao();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Produtos cadastrados com sucesso"),
                                  ),
                                );
                                Navigator.pop(context);
                              } catch (error) {
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Atenção!"),
                                      content: ListView(
                                        children: [
                                          Text(
                                              "Não foi possivel cadastrar os produtos: Erro $error"),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Fechar"))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text("Confirmar"))
                      ],
                    );
                  });
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text("Ajuste db"),
          //   onTap: () async {
          //     try {
          //       Produtodao().adicionarColunaImagem();
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text("Tabela criada com sucesso")));
          //     } catch (error) {
          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //           content: Text("Error ao criar a coluna imagem: $error")));
          //     }
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text("remover db"),
          //   onTap: () async {
          //     try {
          //       Produtodao().removerbd();
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //           content: Text("Banco recriado com sucesso. ")));
          //     } catch (error) {
          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //           content: Text("Error ao criar a coluna imagem: $error")));
          //     }
          //   },
          // )
        ],
      ),
    );
  }
}
