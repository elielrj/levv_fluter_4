import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/controller/cadastrar/nivel_1/cadastro_nivel_1_controller.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
import 'package:levv4/view/cadastrar/botoes/botao_cadastrar_tela_enviar.dart';
import 'package:levv4/view/cadastrar/botoes/botao_limpar_tela_enviar.dart';
import 'package:levv4/view/cadastrar/nivel_1/cadastro_nivel_1.dart';
import 'package:levv4/view/enviar/tela_enviar.dart';
import '../../../api/cor/colors_levv.dart';

class TelaCadastrarEnviar extends StatefulWidget {
  const TelaCadastrarEnviar({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;

  @override
  State<TelaCadastrarEnviar> createState() => _TelaCadastrarEnviarState();
}

class _TelaCadastrarEnviarState extends State<TelaCadastrarEnviar> {
  final cadastroNivel1Controller = CadastroNivel1Controller();

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
                CadastroNivel1(controller: cadastroNivel1Controller),

                /// Campo 6
                ///
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///botão Cadastrar
                    GestureDetector(
                        onTap: () => cadastrarPerfilEnviar(),
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

  Enviar montarObjetoEnviar() => Enviar(
        nome: cadastroNivel1Controller.controllerNome.text,
        sobrenome: cadastroNivel1Controller.controllerSobrenome.text,
        cpf: cadastroNivel1Controller
            .controllerMaskCpf.textEditingController.text
            .toString(),
        nascimento: DateFormat('dd/MM/yyyy')
            .parse(cadastroNivel1Controller
                .controllerMaskNascimento.textEditingController.text)
            .toLocal(),
        documentoDeIdentificacao:
            cadastroNivel1Controller.documentoDeIdentificacao,
      );

  Future<void> atualizarCadastrarDoUsuarioComPerfilDeEnviar(
      Usuario usuario) async {
    //Atuaizar Usuario e criar perfil atual
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.atualizar(usuario);
  }

  Future<void> cadastrarPerfilEnviar() async {
    /// 01 - validar campo ou...
    if (cadastroNivel1Controller.validador()) {
      /// 03 - criar objeto Enviar
      final enviar = montarObjetoEnviar();

      /// 04 - atualizar o perfil do usuario
      widget.usuario.perfil = enviar;

      try {
        /// 05 - atualizar o novo perfil no banco por meio do controller
        await atualizarCadastrarDoUsuarioComPerfilDeEnviar(widget.usuario);

        /// 06 - Navegar para tela de Enviar Pedidos
        _navegarParaTelaEnviar();
      } catch (error) {
        /// 07 - exibir msg erro ao tentar cadastrar
        print(
            "Tela Cadastrar Perfil Enviar Pedido--> erro: ${error.toString()}");
        _exibirMensagemDeErroAoTentarCadastrar(error.toString());
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
    }
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

  _navegarParaTelaEnviar() => Navigator.pushReplacement(
      context, //pushReplacement?? ou só push?
      MaterialPageRoute(
          builder: (context) => TelaEnviar(
                usuario: widget.usuario,
              )));

  limparCampos() {
    cadastroNivel1Controller.limparCampos();
  }
}
