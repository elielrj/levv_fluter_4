import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/controller/cadastrar/nivel_1/cadastro_nivel_1_controller.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

class TelaCadastrarEnviarController {

  final cadastroNivel1Controller = CadastroNivel1Controller();


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
      usuario.perfil = enviar;

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
      if (!widget.controller.cadastroNivel1Controller.validarNome()) {
        _exibirMensagemDeCampoNomeVazio();
      } else if (!widget.controller.cadastroNivel1Controller
          .validarSobrenome()) {
        _exibirMensagemDeCampoSobrenomeVazio();
      } else if (!widget.controller.cadastroNivel1Controller.validarCpf()) {
        _exibirMensagemDeCampoCpfInvalido();
      } else if (!widget.controller.cadastroNivel1Controller
          .validarDataNascimento()) {
        _exibirMensagemDeCampoDataDeNascimentoInvalido();
      } else if (!widget.controller.cadastroNivel1Controller
          .validarDocumentoDeIdentificacao()) {
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

  limparCampos(){
    cadastroNivel1Controller.limparCampos();
  }
}
