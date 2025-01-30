import 'package:flutter/material.dart';
import 'package:listfy/data/provider.dart';
import 'package:listfy/screen/primeiraTela.dart';
// import 'package:listfy/screen/TelaDeProdutosPegos.dart';
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
            leading: const Icon(Icons.home),
            title: const Text('Lista de Compras'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contextNew) => const PrimeiraTela()));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.shopping_cart_outlined),
          //   title: const Text('Carrinho'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (contextNew) => const TelaDeProdutosPegos()));
          //   },
          // ),
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
                            child: const Text("Cancelar",
                                style: TextStyle(color: Colors.red))),
                        ElevatedButton(
                            onPressed: () async {
                              await Provider.of<ProdutoProvider>(context,
                                      listen: false)
                                  .adicionarProdutopadrao();
                              Navigator.pop(context);
                            },
                            child: const Text("Add Lista"))
                      ],
                    );
                  });
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Configurações'),
          //   onTap: () {
          //     Navigator.pop(context); // Fecha o Drawer
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.info),
          //   title: const Text('Sobre'),
          //   onTap: () {
          //     Navigator.pop(context); // Fecha o Drawer
          //   },
          // ),
        ],
      ),
    );
  }
}
