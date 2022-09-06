import 'package:flutter/material.dart';

import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/frontend/colors_levv.dart';

class TelaEntregar extends StatefulWidget {
  const TelaEntregar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEntregar> createState() => _TelaEntregarState();
}

class _TelaEntregarState extends State<TelaEntregar> {

  List<Endereco> listaDeEnderecos = [];
  String valorSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Entregar um produto"),
        ),
        backgroundColor: ColorsLevv.FUNDO,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: listaDeEnderecos.length,
              itemBuilder: (contex, indice) {
                return ListTile(
                    title: const Text("número do pedido e valor"),
                    subtitle: Column(
                      children: const [
                        Text("endereço coleta"),
                        Text("endereço entrega"),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("titulo"),
                              titlePadding: EdgeInsets.all(20),
                              titleTextStyle:
                              TextStyle(fontSize: 20, color: Colors.green),
                              content: Text("conteudo"),
                              actions: [
                                /*
                                FlatButton(

                                    onPressed: ()  {
                                      valorSelecionado = "";
                                    },

                                    child: Text("Sim")),
                                FlatButton(

                                    onPressed: ()  {
                                      valorSelecionado = "";
                                    },

                                    child: Text("Não")), */
                              ],
                            );
                          });
                    });
              }),
        ));
  }
}
