import 'package:flutter/material.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/view/acompanhar/tela_acompanhar.dart';
import 'package:levv4/view/cadastrar/entregar/tela_cadastrar_entregador.dart';
import 'package:levv4/view/cadastrar/enviar/tela_cadastrar_enviar.dart';
import 'package:levv4/view/entregar/tela_entregar.dart';
import 'package:levv4/view/enviar/tela_enviar.dart';

import '../../model/bo/usuario/usuario.dart';
import '../../api/cor/colors_levv.dart';
import '../../api/imagem/image_levv.dart';
import '../../api/texto/text_levv.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  @override
  void initState() {
    super.initState();
    widget.usuario.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO_400,
      appBar: AppBar(
        title: Row(
          children: [
            const Text(TextLevv.NOME_DO_APP + ": "),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.admin_panel_settings),
            Text(widget.usuario.perfil!.exibirPerfil()),
          ],
        ),
        actions: const [
          Icon(Icons.build),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.only(bottom: 57),
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      ImageLevv.LOGO_DO_APP_LEVV,
                      width: 90,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: 400,
                    height: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(32),
                          shadowColor: Colors.black,
                          elevation: 3,
                          backgroundColor: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(ImageLevv.TRACK_DELIVERY, height: 40),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                TextLevv.TITULO_ACOMPANHAR,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                    letterSpacing: 1.4,
                                    wordSpacing: 3),
                              ),
                              Text(
                                TextLevv.SUB_TITULO_ACOMPANHAR,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                      onPressed: () => _navegarParaTelaAcompanhar(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: 400,
                    height: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(32),
                          shadowColor: Colors.black,
                          elevation: 3,
                          backgroundColor: Colors.white),
                      onPressed: () => _navegarParaTelaEnviar(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(ImageLevv.SEND_PRODUCT, height: 40),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                TextLevv.TITULO_ENVIAR,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                    letterSpacing: 1.4,
                                    wordSpacing: 3),
                              ),
                              Text(
                                TextLevv.SUB_TITULO_ENVIAR,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: 400,
                    height: 120,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(32),
                            shadowColor: Colors.black,
                            elevation: 3,
                            backgroundColor: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(ImageLevv.MOTO_DELIVERY, height: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  TextLevv.TITULO_ENTREGAR,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 1.4,
                                      wordSpacing: 3),
                                ),
                                Text(
                                  TextLevv.SUB_TITULO_ENTREGAR,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 14),
                                )
                              ],
                            )
                          ],
                        ),
                        onPressed: () => _navegarParaTelaEntregar()),
                  ),
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => _navegarParaTelaEnviar(),
      ),
    );
  }

  _navegarParaTelaEnviar() {
    if (widget.usuario.perfil is Enviar) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TelaEnviar(usuario: widget.usuario)));
    } else {
      _exibirMensagemDeErroParaAcessarTelaEnviar();
    }
  }

  _navegarParaTelaAcompanhar() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TelaAcompanhar(usuario: widget.usuario)));
  }

  _navegarParaTelaEntregar() {
    if (widget.usuario.perfil is Entregar) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TelaEntregar(usuario: widget.usuario)));
    } else {
      _exibirMensagemDeErroParaAcessarTelaEntregar();
    }
  }

  _exibirMensagemDeErroParaAcessarTelaEnviar() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Perfil incompatível"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: Text(
                "O seu perfil é ${widget.usuario.perfil!.exibirPerfil()}!\n"
                "Para poder enviar um pedido, é necessário que você "
                "esteja cadastrado como nosso cliente.\n"
                "Deseja se cadastrar?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaCadastrarEnviar(
                                  usuario: widget.usuario,
                                )));
                  },
                  child: const Text("Sim")),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Não")),
            ],
          );
        });
  }

  _exibirMensagemDeErroParaAcessarTelaEntregar() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Perfil incompatível"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: Text(
                "O seu perfil é ${widget.usuario.perfil!.exibirPerfil()}!\n"
                "Para poder entregar um pedido, é necessário que você "
                "esteja cadastrado como nosso colaborador.\n"
                "Deseja se cadastrar?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaCadastrarEntregador(
                                  usuario: widget.usuario,
                                )));
                  },
                  child: const Text("Sim")),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Não")),
            ],
          );
        });
  }
}
