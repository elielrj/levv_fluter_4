import 'package:flutter/material.dart';
import 'package:levv4/api/mascara/formatter_cpf.dart';
import 'package:levv4/api/mascara/formatter_date.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/controller/cadastrar/enviar/tela_cadastrar_enviar_controller.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/view/enviar/tela_enviar.dart';

class BotoesCadastrarLimpar extends StatefulWidget {
  BotoesCadastrarLimpar(
      {Key? key, required this.usuario, required this.controller})
      : super(key: key);

  Usuario usuario;

  ///CONTROLLES
  TelaCadastrarEnviarController controller = TelaCadastrarEnviarController();

  @override
  State<BotoesCadastrarLimpar> createState() => _BotoesCadastrarLimparState();
}

class _BotoesCadastrarLimparState extends State<BotoesCadastrarLimpar> {
  @override
  void initState() {
    super.initState();
    widget.controller.controllerMaskCpf.textEditingController
        .addListener(() => setState(() {}));
    widget.controller.controllerMaskNascimento.textEditingController
        .addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///botão Cadastrar
        _cadastrar(),

        ///botão limpar
        _limpar(),
      ],
    );
  }

  Widget _cadastrar() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(190, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () => _cadastrarPerfilEnviar(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                "imagens/icon_register.png",
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text("Cadastrar"),
            ),
          ],
        ),
      );

  Widget _limpar() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(8),
          minimumSize: const Size(190, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),

        ///Widget Pai fará o controler de acionamento
        ///
        onPressed: () => widget.controller.limparCampos(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                "imagens/icon_trash.png",
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text("Limpar"),
            ),
          ],
        ),
      );

  Future<void> _cadastrarPerfilEnviar() async {
    /// 01 - validar campo ou...
    if (widget.controller.validador()) {
      /// 03 - criar objeto Enviar
      final enviar = widget.controller.montarObjetoEnviar();

      /// 04 - atualizar o perfil do usuario
      widget.usuario.perfil = enviar;

      try {
        /// 05 - atualizar o novo perfil no banco por meio do controller
        await widget.controller
            .atualizarCadastrarDoUsuarioComPerfilDeEnviar(widget.usuario);

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

      if(!widget.controller.validarNome()){
        _exibirMensagemDeCampoNomeVazio();
      }else if(!widget.controller.validarSobrenome()){
        _exibirMensagemDeCampoSobrenomeVazio();
      }else if(!widget.controller.validarCpf()){
        _exibirMensagemDeCampoCpfInvalido();
      }else if(!widget.controller.validarDataNascimento()){
        _exibirMensagemDeCampoDataDeNascimentoInvalido();
      }else if(!widget.controller.validarDocumentoDeIdentificacao()){
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
}
