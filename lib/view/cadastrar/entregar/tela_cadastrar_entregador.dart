import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/biblioteca/imagem/image_levv.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';
import 'package:levv4/controller/cadastrar/endereco/tela_cadastrar_endereco_controller.dart';
import 'package:levv4/controller/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte_controller.dart';
import 'package:levv4/controller/cadastrar/nivel_1/cadastro_nivel_1_controller.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
import 'package:levv4/view/cadastrar/endereco/tela_cadastrar_endereco.dart';
import 'package:levv4/view/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte.dart';
import 'package:levv4/view/cadastrar/nivel_1/cadastro_nivel_1.dart';
import 'package:levv4/view/entregar/tela_entregar.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/biblioteca/cor/colors_levv.dart';

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

  @override
  void initState() {
    super.initState();
    widget.usuario.perfil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextLevv.CADASTRAR_PERFIL_ENTREGADOR),
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
                    TextLevv.MEIO_PARA_TRANSPORTAR_PEDIDOS,
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
      backgroundColor: FUNDO_400,
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
        onPressed: () async {
          if (!controllerEndereco.validarGeolocalizacao()) {
            await controllerEndereco.buscarLocalizacaoAtual();
          }
          _cadastrarPerfilEntregador();
        },
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

  limparCampos() {
    cadastroNivel1Controller.limparCampos();
    controllerMeioDeTransportes.limparTodosOsCampos();
    controllerEndereco.limparTodosOsCampos();
    setState(() {
      controllerEndereco.color;
    });
  }

  bool validarDados() {
    return cadastroNivel1Controller.validador() &&
        controllerEndereco.validador() &&
        controllerMeioDeTransportes.validador();
  }

  Endereco montarObjetoEnderecoCasa() => Endereco(
        logradouro: controllerEndereco.logradouro.text.toString(),
        numero: controllerEndereco.numero.text.toString(),
        complemento: controllerEndereco.complemento.text.toString(),
        cep: controllerEndereco.cepMask.formatter
            .getMaskTextInputFormatter()
            .getUnmaskedText(),
        geolocalizacao: controllerEndereco.geoPoint,
        bairro: controllerEndereco.bairro.text.toString(),
        cidade: controllerEndereco.cidade.text.toString(),
        estado: controllerEndereco.estado.text.toString(),
        pais: controllerEndereco.pais.text.toString(),
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
      setState(() {
        widget.usuario.perfil = entregador;
      });
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
      else if (controllerMeioDeTransportes.valueMeioDeTransporte != 0 &&
          controllerMeioDeTransportes.valueMeioDeTransporte != 1) {
        if (!controllerMeioDeTransportes.validarModelo()) {
          _exibirMensagemDeCampoModelo();
        } else if (!controllerMeioDeTransportes.validarMarca()) {
          _exibirMensagemDeCampoMarca();
        } else if (!controllerMeioDeTransportes.validarCor()) {
          _exibirMensagemDeCampoCor();
        } else if (!controllerMeioDeTransportes.validarPlaca()) {
          _exibirMensagemDeCampoPlaca();
        } else if (!controllerMeioDeTransportes.validarRenavan()){
          _exibirMensagemDeCampoRenavan();
        } else if (!controllerMeioDeTransportes.validarDocumentoDoVeiculo()) {
          _exibirMensagemDeCampoDocumentoDoVeiculo();
        }
      }

      ///Mensagem de erro p/ campos de Endereco
      else if (!controllerEndereco.validarLogradouro()) {
        _exibirMensagemDeCampoLogradouro();
      } else if (!controllerEndereco.validarNumero()) {
        _exibirMensagemDeCampoNumero();
      } else if (!controllerEndereco.validarComplemento()) {
        _exibirMensagemDeCampoComplemento();
      } else if (!controllerEndereco.validarCep()) {
        _exibirMensagemDeCampoCep();
      } else if (!controllerEndereco.validarBairro()) {
        _exibirMensagemDeCampoBairro();
      } else if (!controllerEndereco.validarCidade()) {
        _exibirMensagemDeCampoCidade();
      } else if (!controllerEndereco.validarEstado()) {
        _exibirMensagemDeCampoEstado();
      } else if (!controllerEndereco.validarGeolocalizacao()) {
        _exibirMensagemDeCampoGeolocalizacao();
      }
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
      _exibirMensagemDeErro(TextLevv.ERRO_NOME_INVALIDO);

  _exibirMensagemDeCampoSobrenomeVazio() =>
      _exibirMensagemDeErro(TextLevv.ERRO_SOBRENOME_INVALIDO);

  _exibirMensagemDeCampoCpfInvalido() =>
      _exibirMensagemDeErro(TextLevv.ERRO_CPF_INVALIDA);

  _exibirMensagemDeCampoDataDeNascimentoInvalido() =>
      _exibirMensagemDeErro(TextLevv.ERRO_DATA_NASCIMENTO_INVALIDA);

  _exibirMensagemDeCampoDocumentoVazio() =>
      _exibirMensagemDeErro(TextLevv.ERRO_DOCUMENTO_IDENTIFICACAO_INVALIDO);

  _exibirMensagemDeCampoModelo() =>
      _exibirMensagemDeErro(TextLevv.ERRO_MODELO_INVALIDO);

  _exibirMensagemDeCampoMarca() =>
      _exibirMensagemDeErro(TextLevv.ERRO_MARCA_INVALIDO);

  _exibirMensagemDeCampoCor() =>
      _exibirMensagemDeErro(TextLevv.ERRO_COR_INVALIDO);

  _exibirMensagemDeCampoLogradouro() =>
      _exibirMensagemDeErro(TextLevv.ERRO_LOGRADOURO_INVALIDO);

  _exibirMensagemDeCampoGeolocalizacao() =>
      _exibirMensagemDeErro(TextLevv.ERRO_GEO_INVALIDO);

  _exibirMensagemDeCampoEstado() =>
      _exibirMensagemDeErro(TextLevv.ERRO_ESTADO_INVALIDO);

  _exibirMensagemDeCampoCidade() =>
      _exibirMensagemDeErro(TextLevv.ERRO_CIDADE_INVALIDO);

  _exibirMensagemDeCampoBairro() =>
      _exibirMensagemDeErro(TextLevv.ERRO_BAIRRO_INVALIDO);

  _exibirMensagemDeCampoComplemento() =>
      _exibirMensagemDeErro(TextLevv.ERRO_COMPLEMENTO_INVALIDO);

  _exibirMensagemDeCampoCep() =>
      _exibirMensagemDeErro(TextLevv.ERRO_CEP_INVALIDO);

  _exibirMensagemDeCampoNumero() =>
      _exibirMensagemDeErro(TextLevv.ERRO_NUMERO_INVALIDO);

  _exibirMensagemDeCampoDocumentoDoVeiculo() =>
      _exibirMensagemDeErro(TextLevv.ERRO_DOCUMENTO_VEICULO_INVALIDO);

  _exibirMensagemDeCampoPlaca() =>
      _exibirMensagemDeErro(TextLevv.ERRO_PLACA_INVALIDO);

  _exibirMensagemDeCampoRenavan() =>
      _exibirMensagemDeErro(TextLevv.ERRO_RENAVAN_INVALIDO);

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
}
