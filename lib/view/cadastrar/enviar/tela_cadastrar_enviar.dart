import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/api/imagem/image_levv.dart';
import 'package:levv4/api/texto/text_levv.dart';
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
    widget.usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextLevv.CADASTRAR_PERFIL_ENVIAR),
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
                    _botaoCadastrar(),

                    ///botão limpar
                    _botaoLimpar(),
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

  Widget _botaoCadastrar() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(190, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () => cadastrarPerfilEnviar(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                ImageLevv.REGISTER,
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text(TextLevv.CADASTRAR),
            ),
          ],
        ),
      );

  Widget _botaoLimpar() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(190, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () => limparCampos(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                ImageLevv.ICON_TRASH,
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text(TextLevv.LIMPAR),
            ),
          ],
        ),
      );

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
      setState(() {
        widget.usuario.perfil = enviar;
        widget.usuario;
      });

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
      _exibirMensagemDeErro(TextLevv.ERRO_NOME_INVALIDO);

  _exibirMensagemDeCampoSobrenomeVazio() =>
      _exibirMensagemDeErro(TextLevv.ERRO_SOBRENOME_INVALIDO);

  _exibirMensagemDeCampoCpfInvalido() =>
      _exibirMensagemDeErro(TextLevv.ERRO_CPF_INVALIDA);

  _exibirMensagemDeCampoDataDeNascimentoInvalido() =>
      _exibirMensagemDeErro(TextLevv.ERRO_DATA_NASCIMENTO_INVALIDA);

  _exibirMensagemDeCampoDocumentoVazio() =>
      _exibirMensagemDeErro(TextLevv.ERRO_DOCUMENTO_IDENTIFICACAO_INVALIDO);

  _exibirMensagemDeErro(String mensagem) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(TextLevv.CAMPO_VAZIO),
          titlePadding: const EdgeInsets.all(20),
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
          content: Text(mensagem),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(TextLevv.OK))
          ],
        );
      });

  _exibirMensagemDeErroAoTentarCadastrar(String mensagem) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(TextLevv.ERRO_AO_TENTAR_CADASTRAR),
          titlePadding: const EdgeInsets.all(20),
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
          content: Text(mensagem),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(TextLevv.OK))
          ],
        );
      });

  _navegarParaTelaEnviar() => Navigator.pushReplacement(
      context, //pushReplacement?? ou só push?
      MaterialPageRoute(
          builder: (context) => TelaEnviar(
                usuario: widget.usuario,
              )));

  void limparCampos() {
    cadastroNivel1Controller.limparCampos();
  }
}
