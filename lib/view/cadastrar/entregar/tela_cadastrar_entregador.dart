import 'package:flutter/material.dart';

import 'package:levv4/view/cadastrar/endereco/tela_cadastrar_endereco.dart';
import 'package:levv4/view/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte.dart';
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
    controller.controllerNome.addListener(() => setState(() {}));
    controller.controllerSobrenome.addListener(() => setState(() {}));
    controller.controllerMaskCpf.textEditingController
        .addListener(() => setState(() {}));
    controller.controllerMaskNascimento.textEditingController
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
                /// Campo 1
                TextFieldCustomizedForName(
                    controller.controllerNome,  nome),

                /// Campo 2
                TextFieldCustomizedForName(controller.controllerSobrenome,
                     sobrenome,
                    maxLength: 150),

                /// Campo 3
                TextFieldCustomizedForCpf(
                    controller.controllerMaskCpf),

                /// Campo 4
                TextFieldCustomizedForDate(controller.controllerMaskNascimento,
                     dataNascimento),

                /// Campo 5
                DocumentoDeIdentificacao(
                    documento: controller.documentoDeIdentificacao),

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
                    GestureDetector(
                      onTap: _cadastrarPerfilEntregador,
                      child: TextButtonCustomizedCadastrar(),
                    ),

                    /// Campo botão limpar
                    GestureDetector(
                      onTap: () => _limparCampos(),
                      child: TextButtonCustomizedLimpar(),
                    ),
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

  _limparCampos() {
    controller.limparTodosOsCampos();
    controller.controllerMeioDeTransportes.limparTodosOsCampos();
    controller.controllerEndereco.limparTodosOsCampos();
  }

  validarDados() {
    return controller.validador() &&
        controller.controllerEndereco.validador() &&
        controller.controllerMeioDeTransportes.validador();
  }

  Future<void> _cadastrarPerfilEntregador() async {
    /// 01 - validar campo ou...
    if (validarDados()) {
      /// 03 - criar objeto Entregar
      final entregador = controller.montarObjetoEntregar();

      /// 04 - atualizar o perfil do usuario
      widget.usuario.perfil = entregador;
      try {
        /// 05 - atualizar o novo perfil no banco por meio do controller
        await controller
            .atualizarCadastroDOUsuarioComPerfilDeEntregador(widget.usuario);

        /// 06 - Navegar para tela de Entregar Pedidos
        _navegarParaTelaEntregar();
      } catch (erro) {
        /// 07 - exibir msg erro ao tentar cadastrar
        print(
            "Tela Cadastrar Perfil Entregar Pedido--> erro: ${erro.toString()}");
        _exibirMensagemDeErroAoTentarCadastrar(erro.toString());
      }

      /// 02 - exibir msg erro
    } else {
      controller.validarNome()
          ? Container(width: 0)
          : _exibirMensagemDeCampoNomeVazio();
      controller.validarSobrenome()
          ? Container(width: 0)
          : _exibirMensagemDeCampoSobrenomeVazio();
      controller.validarCpf()
          ? Container(width: 0)
          : _exibirMensagemDeCampoCpfVazio();
      controller.validarDataNascimento()
          ? Container(width: 0)
          : _exibirMensagemDeCampoDataDeNascimentoVazio();
      controller.validarDocumentoDeIdentificacao()
          ? Container(width: 0)
          : _exibirMensagemDeCampoDocumentoVazio();

      ///Mensagem de erro p/ campos de meio de transporte
      controller.controllerMeioDeTransportes.validarModelo()
          ? Container(width: 0)
          : _exibirMensagemDeCampoModelo();
      controller.controllerMeioDeTransportes.validarMarca()
          ? Container(width: 0)
          : _exibirMensagemDeCampoMarca();
      controller.controllerMeioDeTransportes.validarCor()
          ? Container(width: 0)
          : _exibirMensagemDeCampoCor();
      controller.controllerMeioDeTransportes.validarPlaca()
          ? Container(width: 0)
          : _exibirMensagemDeCampoPlaca();
      controller.controllerMeioDeTransportes.validarDocumentoDoVeiculo()
          ? Container(width: 0)
          : _exibirMensagemDeCampoDocumentoDoVeiculo();

      ///Mensagem de erro p/ campos de Endereco
      controller.controllerEndereco.validarLogradouro()
          ? Container(width: 0)
          : _exibirMensagemDeCampoLogradouro();
      controller.controllerEndereco.validarNumero()
          ? Container(width: 0)
          : _exibirMensagemDeCampoNumero();
      controller.controllerEndereco.validarComplemento()
          ? Container(width: 0)
          : _exibirMensagemDeCampoComplemento();
      controller.controllerEndereco.validarCep()
          ? Container(width: 0)
          : _exibirMensagemDeCampoCor();
      controller.controllerEndereco.validarBairro()
          ? Container(width: 0)
          : _exibirMensagemDeCampoBairro();
      controller.controllerEndereco.validarCidade()
          ? Container(width: 0)
          : _exibirMensagemDeCampoCidade();
      controller.controllerEndereco.validarEstado()
          ? Container(width: 0)
          : _exibirMensagemDeCampoEstado();
      controller.controllerEndereco.validarGeolocalizacao()
          ? Container(width: 0)
          : _exibirMensagemDeCampoGeolocalizacao();
    }
  }

  _navegarParaTelaEntregar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaEntregar(
                  usuario: widget.usuario,
                )));
  }

  _exibirMensagemDeCampoNomeVazio() =>
      _exibirMensagemDeErro("O campo de nome está vazio!");

  _exibirMensagemDeCampoSobrenomeVazio() =>
      _exibirMensagemDeErro("O campo de sobrenome está vazio!");

  _exibirMensagemDeCampoCpfVazio() =>
      _exibirMensagemDeErro("O campo de CPF está vazio!");

  _exibirMensagemDeCampoDataDeNascimentoVazio() =>
      _exibirMensagemDeErro("O campo de Data de Nascimento está vazio!");

  _exibirMensagemDeCampoDocumentoVazio() =>
      _exibirMensagemDeErro("O campo de documento está vazio!");

  _exibirMensagemDeCampoModelo() =>
      _exibirMensagemDeErro("O campo de modelo está vazio!");

  _exibirMensagemDeCampoMarca() =>
      _exibirMensagemDeErro("O campo de marca está vazio!");

  _exibirMensagemDeCampoCor() =>
      _exibirMensagemDeErro("O campo de cor está vazio!");

  _exibirMensagemDeCampoLogradouro() =>
      _exibirMensagemDeErro("O campo de logradouro está vazio!");

  _exibirMensagemDeCampoGeolocalizacao() =>
      _exibirMensagemDeErro("O campo de GPS está vazio!");

  _exibirMensagemDeCampoEstado() =>
      _exibirMensagemDeErro("O campo de estado está vazio!");

  _exibirMensagemDeCampoCidade() =>
      _exibirMensagemDeErro("O campo de cidade está vazio!");

  _exibirMensagemDeCampoBairro() =>
      _exibirMensagemDeErro("O campo de bairro está vazio!");

  _exibirMensagemDeCampoComplemento() =>
      _exibirMensagemDeErro("O campo de complemento está vazio!");

  _exibirMensagemDeCampoNumero() =>
      _exibirMensagemDeErro("O campo de numero está vazio!");

  _exibirMensagemDeCampoDocumentoDoVeiculo() =>
      _exibirMensagemDeErro("O campo de veículo está vazio!");

  _exibirMensagemDeCampoPlaca() =>
      _exibirMensagemDeErro("O campo de placa está vazio!");

  _exibirMensagemDeErro(String mensagem) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Campo Vazio"),
          titlePadding: const EdgeInsets.all(20),
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
          content: Text(mensagem),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });

  _exibirMensagemDeErroAoTentarCadastrar(String mensagem) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Erro ao tentar cadastrar!"),
          titlePadding: const EdgeInsets.all(20),
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
          content: Text(mensagem),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });
}
