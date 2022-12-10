import 'package:flutter/material.dart';
import 'package:levv4/view/cadastrar/botoes/botoes_cadastrar_limpar_do_perfil_entregar.dart';

import 'package:levv4/view/cadastrar/endereco/tela_cadastrar_endereco.dart';
import 'package:levv4/view/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte.dart';
import 'package:levv4/view/cadastrar/nivel_1/cadastro_nivel_1.dart';
import 'package:levv4/view/componentes/botoes/botao_cadastrar.dart';
import 'package:levv4/view/componentes/botoes/botao_limpar.dart';
import 'package:levv4/view/componentes/documento_de_identificacao/documento_de_identificacao.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_cpf.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_date.dart';
import 'package:levv4/view/entregar/tela_entregar.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_name.dart';
import 'package:levv4/controller/cadastrar/entregar/tela_cadastrar_entregar_controller.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/api/cor/colors_levv.dart';

class TelaCadastrarEntregador extends StatefulWidget {
  const TelaCadastrarEntregador({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;

  @override
  State<TelaCadastrarEntregador> createState() =>
      _TelaCadastrarEntregadorState();
}

class _TelaCadastrarEntregadorState extends State<TelaCadastrarEntregador> {
  final controller = TelaCadastrarEntregadorController();

  final String cpf = "CPF";
  final String sobrenome = "Sobrenome";
  final String nome = "Nome";
  final String dataNascimento = "Data de nascimento";

  @override
  void initState() {
    super.initState();
    controller.cadastroNivel1Controller.controllerNome
        .addListener(() => setState(() {}));
    controller.cadastroNivel1Controller.controllerSobrenome
        .addListener(() => setState(() {}));
    controller.cadastroNivel1Controller.controllerMaskCpf.textEditingController
        .addListener(() => setState(() {}));
    controller
        .cadastroNivel1Controller.controllerMaskNascimento.textEditingController
        .addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar perfil: Entregar"),
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
                CadastroNivel1(controller: controller.cadastroNivel1Controller),

                /// Campo 6 - veículo
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Meio que utilizará para transportar pedidos",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                /// Campo de cadastro de Meio de transporte
                TelaCadastrarMeioDeTransporte(
                    controller: controller.controllerMeioDeTransportes),

                /// Campo Endereço
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Endereço particular",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),

                /// Tela de Cadastro de Endereço
                TelaCadastrarEndereco(
                    controller: controller.controllerEndereco),

                /// Campo de botões
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Campo Botão Cadastrar
                    BotoesCastrarLimparDoPerfilEntregar(
                        usuario: widget.usuario, controller: controller)

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
