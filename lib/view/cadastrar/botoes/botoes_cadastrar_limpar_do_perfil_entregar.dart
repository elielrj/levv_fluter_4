import 'package:flutter/material.dart';
import 'package:levv4/controller/cadastrar/entregar/tela_cadastrar_entregar_controller.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';

import '../../entregar/tela_entregar.dart';

class BotoesCastrarLimparDoPerfilEntregar extends StatefulWidget {
  BotoesCastrarLimparDoPerfilEntregar(
      {Key? key, required this.usuario, required this.controller})
      : super(key: key);

  Usuario usuario;

  ///Controllers
  TelaCadastrarEntregadorController controller;

  @override
  State<BotoesCastrarLimparDoPerfilEntregar> createState() =>
      _BotoesCastrarLimparDoPerfilEntregarState();
}

class _BotoesCastrarLimparDoPerfilEntregarState
    extends State<BotoesCastrarLimparDoPerfilEntregar> {

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
    onPressed: () => _cadastrarPerfilEntregador(),
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
    onPressed: () =>
    //todo: mudar o controler de "limpar campos" p/ "controller" principal
        widget.controller.cadastroNivel1Controller.limparCampos(),
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



  Future<void> _cadastrarPerfilEntregador() async {
    /// 01 - validar campo ou...
    if (widget.controller.validarDados()) {
      /// 03 - criar objeto Entregar
      final entregador = widget.controller.montarObjetoEntregar();

      /// 04 - atualizar o perfil do usuario
      widget.usuario.perfil = entregador;
      try {
        /// 05 - atualizar o novo perfil no banco por meio do controller
        await widget.controller
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
