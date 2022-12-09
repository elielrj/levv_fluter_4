import 'package:flutter/material.dart';

import 'package:levv4/api/mascara/formatter_cpf.dart';
import 'package:levv4/api/mascara/formatter_date.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/controller/cadastrar/enviar/tela_cadastrar_enviar_controller.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/view/componentes/documento_de_identificacao/documento_de_identificacao.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_cpf.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_date.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_name.dart';

class CadastroNivel1 extends StatefulWidget {
  CadastroNivel1({
    Key? key,
    required this.controller
  }) : super(key: key);

  ///CONTROLLES
  TelaCadastrarEnviarController controller = TelaCadastrarEnviarController();

  @override
  State<CadastroNivel1> createState() => _CadastroNivel1State();
}

class _CadastroNivel1State extends State<CadastroNivel1> {
  ///TEXT LABEL
  static const labelTextNome = "Nome";
  static const labelTextSobrenome = "Sobrenome";
  static const labelTextNascimento = "Data de Nascimento";

  @override
  void initState() {
    super.initState();
    widget.controller.controllerNome.addListener(() => setState(() {}));
    widget.controller.controllerSobrenome.addListener(() => setState(() {}));
    widget.controller.controllerMaskCpf.textEditingController
        .addListener(() => setState(() {}));
    widget.controller.controllerMaskNascimento.textEditingController
        .addListener(() => setState(() {}));
    widget.controller.documentoDeIdentificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Campo 1
        TextFieldCustomizedForName(widget.controller.controllerNome, labelTextNome),

        /// Campo 2
        TextFieldCustomizedForName(widget.controller.controllerSobrenome, labelTextSobrenome),

        /// Campo 3
        TextFieldCustomizedForCpf(widget.controller.controllerMaskCpf),

        /// Campo 4
        TextFieldCustomizedForDate(
            widget.controller.controllerMaskNascimento, labelTextNascimento),

        /// Campo 5
        DocumentoDeIdentificacao(documento: widget.controller.documentoDeIdentificacao),
      ],
    );
  }
}
