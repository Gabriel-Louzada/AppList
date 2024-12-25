import 'package:flutter/material.dart';
import 'package:listfy/screen/primeiraTela.dart';
import 'package:listfy/screen/produtosPegos.dart';

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
                  'Bem-vindo! ao ListFy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Seu lista de compras de forma facil',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Lista de Compras'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contextNew) => const PrimeiraTela()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Carrinho'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contextNew) => const TelaDeProdutosPegos()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Totalizadores'),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
