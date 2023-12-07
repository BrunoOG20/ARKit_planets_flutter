import 'package:arkit_flutter/earth_page.dart';
import 'package:arkit_flutter/jupiter_page.dart';
import 'package:arkit_flutter/mars_page.dart';
import 'package:arkit_flutter/saturn_page.dart';
import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botoes = [
      Botao(
        'Ver Terra',
        'Visualizar Terra com Realidade Aumentada',
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => const EarthPage())),
      ),
      Botao(
        'Ver Marte',
        'Visualizar Marte com Realidade Aumentada',
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => const MarsPage())),
      ),
      Botao(
        'Ver Saturno',
        'Visualizar Saturno com Realidade Aumentada',
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => const SaturnPage())),
      ),
      Botao(
        'Ver Jupiter',
        'Visualizar Jupiter com Realidade Aumentada',
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (c) => const JupiterPage())),
      ),
    ];

    return MaterialApp(
       home: Scaffold(
        appBar: AppBar(
          title: const Text("Realidade Aumentada"),
        ),
        body: ListView(children: botoes.map((s) => BotaoItem(item: s)).toList()),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BotaoItem extends StatelessWidget {
  const BotaoItem({
    required this.item,
    Key? key,
  }) : super(key: key);
  final Botao item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => item.onTap(),
        child: ListTile(
          leading: const Icon(Icons.language),
          title: Text(
            item.titulo,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            item.descricao,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}

class Botao {
  const Botao(this.titulo, this.descricao,this.onTap);
  final String titulo;
  final String descricao;
  final Function onTap;
}