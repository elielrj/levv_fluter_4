import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/controller/cadastrar/endereco/tela_cadastrar_endereco_controller.dart';
import 'package:levv4/controller/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte_controller.dart';
import 'package:levv4/controller/cadastrar/nivel_1/cadastro_nivel_1_controller.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
import 'package:levv4/view/cadastrar/botoes/botao_cadastrar_tela_enviar.dart';
import 'package:levv4/view/cadastrar/botoes/botao_limpar_tela_enviar.dart';
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
  final cadastroNivel1Controller = CadastroNivel1Controller();
  final controllerMeioDeTransportes = TelaCadastrarMeioDeTransporteController();
  final controllerEndereco = TelaCadastrarEnderecoController();

  final String cpf = "CPF";
  final String sobrenome = "Sobrenome";
  final String nome = "Nome";
  final String dataNascimento = "Data de nascimento";

  @override
  void initState() {
    super.initState();
    widget.usuario.perfil;
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
                CadastroNivel1(controller: cadastroNivel1Controller),

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
                    controller: controllerMeioDeTransportes),

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
                TelaCadastrarEndereco(controller: controllerEndereco),

                /// Campo de botões
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///botão Cadastrar
                    GestureDetector(
                        onTap: () => _cadastrarPerfilEntregador(),
                        child: const BotaoCadastrarTelaEnviar()),

                    ///botão limpar
                    GestureDetector(
                        onTap: () => limparCampos(),
                        child: const BotaoLimparTelaEnviar())
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

  limparCampos() {
    cadastroNivel1Controller.limparCampos();
    controllerMeioDeTransportes.limparTodosOsCampos();
    controllerEndereco.limparTodosOsCampos();
  }

  bool validarDados() {
    return cadastroNivel1Controller.validador() &&
        controllerEndereco.validador() &&
        controllerMeioDeTransportes.validador();
  }

  Endereco montarObjetoEnderecoCasa() => Endereco(
        logradouro: controllerEndereco.logradouro.text.toString(),
        numero: controllerEndereco.numero.toString(),
        complemento: controllerEndereco.complemento.text.toString(),
        cep: controllerEndereco.cepMask.formatter
            .getMaskTextInputFormatter()
            .getUnmaskedText(),
        geolocalizacao: controllerEndereco.geoPoint,
        bairro: controllerEndereco.bairro.text.toString(),
        cidade: controllerEndereco.cidade.text.toString(),
        estado: controllerEndereco.estado.text.toString(),
      );

  MeioDeTransporte montarObjetoMeioDeTransporte() {
    return controllerMeioDeTransportes.meioDeTransporteSelecionado();
  }

  Entregar montarObjetoEntregar() => Entregar(
        nome: cadastroNivel1Controller.controllerNome.text.toString(),
        sobrenome: cadastroNivel1Controller.controllerSobrenome.text.toString(),
        cpf: cadastroNivel1Controller.controllerMaskCpf.formatter
            .getMaskTextInputFormatter()
            .getUnmaskedText()
            .toString(),
        nascimento: DateFormat('dd/MM/yyyy').parse(cadastroNivel1Controller
            .controllerMaskNascimento.textEditingController.text),
        casa: montarObjetoEnderecoCasa(),
        documentoDeIdentificacao:
            cadastroNivel1Controller.documentoDeIdentificacao,
        meioDeTransporte: montarObjetoMeioDeTransporte(),
      );

  Future<void> atualizarCadastroDoUsuarioComPerfilDeEntregador(
      Usuario usuario) async {
    //atualizar Usuario e criar perfil atual
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.atualizar(usuario);
  }

  Future<void> _cadastrarPerfilEntregador() async {
    /// 01 - validar campo ou...
    if (validarDados()) {
      /// 03 - criar objeto Entregar
      final entregador = montarObjetoEntregar();

      /// 04 - atualizar o perfil do usuario
      widget.usuario.perfil = entregador;
      try {
        /// 05 - atualizar o novo perfil no banco por meio do controller
        await atualizarCadastroDoUsuarioComPerfilDeEntregador(widget.usuario);

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
      if (!cadastroNivel1Controller.validarNome()) {
        _exibirMensagemDeCampoNomeVazio();
      } else if (!cadastroNivel1Controller.validarSobrenome()) {
        _exibirMensagemDeCampoSobrenomeVazio();
      } else if (!cadastroNivel1Controller.validarCpf()) {
        _exibirMensagemDeCampoCpfInvalido();
      } else if (!cadastroNivel1Controller.validarDataNascimento()) {
        _exibirMensagemDeCampoDataDeNascimentoInvalido();
      } else if (!cadastroNivel1Controller.validarDocumentoDeIdentificacao()) {
        _exibirMensagemDeCampoDocumentoVazio();
      }

      ///Mensagem de erro p/ campos de meio de transporte
      controllerMeioDeTransportes.validarModelo()
          ? Container(width: 0)
          : _exibirMensagemDeCampoModelo();
      controllerMeioDeTransportes.validarMarca()
          ? Container(width: 0)
          : _exibirMensagemDeCampoMarca();
      controllerMeioDeTransportes.validarCor()
          ? Container(width: 0)
          : _exibirMensagemDeCampoCor();
      controllerMeioDeTransportes.validarPlaca()
          ? Container(width: 0)
          : _exibirMensagemDeCampoPlaca();
      controllerMeioDeTransportes.validarDocumentoDoVeiculo()
          ? Container(width: 0)
          : _exibirMensagemDeCampoDocumentoDoVeiculo();

      ///Mensagem de erro p/ campos de Endereco
      controllerEndereco.validarLogradouro()
          ? Container(width: 0)
          : _exibirMensagemDeCampoLogradouro();
      controllerEndereco.validarNumero()
          ? Container(width: 0)
          : _exibirMensagemDeCampoNumero();
      controllerEndereco.validarComplemento()
          ? Container(width: 0)
          : _exibirMensagemDeCampoComplemento();
      controllerEndereco.validarCep()
          ? Container(width: 0)
          : _exibirMensagemDeCampoCor();
      controllerEndereco.validarBairro()
          ? Container(width: 0)
          : _exibirMensagemDeCampoBairro();
      controllerEndereco.validarCidade()
          ? Container(width: 0)
          : _exibirMensagemDeCampoCidade();
      controllerEndereco.validarEstado()
          ? Container(width: 0)
          : _exibirMensagemDeCampoEstado();
      controllerEndereco.validarGeolocalizacao()
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

  _exibirMensagemDeCampoCpfInvalido() =>
      _exibirMensagemDeErro("O campo de CPF está inválido!");

  _exibirMensagemDeCampoDataDeNascimentoInvalido() =>
      _exibirMensagemDeErro("O campo de Data de Nascimento está inválido!");

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
