import 'package:flutter/material.dart';
import 'package:levv4/controller/cadastrar/enviar/tela_cadastrar_enviar_controller.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/view/cadastrar/botoes/botao_cadastrar_tela_enviar.dart';
import 'package:levv4/view/cadastrar/botoes/botao_limpar_tela_enviar.dart';
import 'package:levv4/view/cadastrar/botoes/botoes_cadastrar_limpar_do_perfil_enviar.dart';
import 'package:levv4/view/cadastrar/nivel_1/cadastro_nivel_1.dart';
import '../../../api/cor/colors_levv.dart';

class TelaCadastrarEnviar extends StatefulWidget {
  const TelaCadastrarEnviar({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;

  @override
  State<TelaCadastrarEnviar> createState() => _TelaCadastrarEnviarState();
}

class _TelaCadastrarEnviarState extends State<TelaCadastrarEnviar> {
  final _controller = TelaCadastrarEnviarController();

  @override
  void initState() {
    super.initState();
    widget.usuario.perfil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar perfil: Enviar"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Campos de 1 à 5
                ///
                CadastroNivel1(
                    controller: _controller.cadastroNivel1Controller),

                /// Campo 6
                ///
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///botão Cadastrar
                    BotaoCadastrarTelaEnviar(controller: _controller),

                    ///botão limpar
                    BotaoLimparTelaEnviar(controller: _controller)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorsLevv.FUNDO_400,
    );
  }
}
