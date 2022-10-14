import 'package:flutter/material.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/controller/cadastrar/enviar/cliente_controller.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

import 'package:levv4/view/enviar/tela_enviar.dart';

import '../../../api/mascara/formatter_cpf.dart';
import '../../../api/mascara/formatter_date.dart';
import '../../../api/mascara/masks_levv.dart';
import '../../../model/bo/arquivo/arquivo.dart';
import '../../../model/bo/usuario/perfil/enviar/enviar.dart';
import '../../../api/cor/colors_levv.dart';

import 'package:intl/intl.dart';

class TelaCadastrarCliente extends StatefulWidget {
  const TelaCadastrarCliente({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;

  @override
  State<TelaCadastrarCliente> createState() => _TelaCadastrarClienteState();
}

class _TelaCadastrarClienteState extends State<TelaCadastrarCliente> {
  final ClienteController _controller = ClienteController();

  String labelTextNome = "Nome";
  String labelTextSobrenome = "Sobrenome";
  String labelTextCpf = "Cpf";
  String labelTextNascimento = "Data de Nascimento";

  @override
  void initState() {
    super.initState();
    _controller.controllerNome.addListener(() => setState(() {}));
    _controller.controllerSobrenome.addListener(() => setState(() {}));
    _controller.controllerMaskCpf.textEditingController
        .addListener(() => setState(() {}));
    _controller.controllerMaskNascimento.textEditingController
        .addListener(() => setState(() {}));
    _controller.documento;
    widget.usuario;
  }

  _cadastrarPerfilEnviar() async {
    if (_controller.camposEstaoValidos()) {
      if (!_controller.documento) {
        _exibirMensagemDeFaltaDeUploadDeDocumento();
      } else {
        Enviar enviar = Enviar(
          nome: _controller.controllerNome.text,
          sobrenome: _controller.controllerSobrenome.text,
          cpf: _controller.controllerMaskCpf.textEditingController.text
              .toString(),
          nascimento: DateFormat('dd/MM/yyyy')
              .parse(_controller
                  .controllerMaskNascimento.textEditingController.text)
              .toLocal(),
          documentoDeIdentificacao: true,
        );

        try {
          final arquivoDAO = ArquivoDAO();
          arquivoDAO.upload(_controller.documentoDeIdentificacao);

          final enviarDAO = EnviarDAO();
          await enviarDAO.criar(enviar);

          widget.usuario.perfil = enviar;

          final usuarioDAO = UsuarioDAO();
          await usuarioDAO.atualizar(widget.usuario);

          _navegarParaTelaEnviar(widget.usuario);
        } catch (error) {
          print("erro: ${error.toString()}");
        }
      }
    } else {
      _exibirMensagemDeCampoVazio();
    }
  }

  _navegarParaTelaEnviar(Usuario usuario) {
    Navigator.pushReplacement(
        context, //pushReplacement?? ou só push?
        MaterialPageRoute(
            builder: (context) => TelaEnviar(
                  usuario: usuario,
                  pedido: Pedido(),
                )));
  }

  _exibirMensagemDeFaltaDeUploadDeDocumento() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Campo Vazio"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: const Text("Envie um documento de identificação!"),
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

  _exibirMensagemDeCampoVazio() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Campo Vazio"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: const Text(
                "Varifique os dados digitados, pois há 1 ou mais campos vazios!"),
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
                TextField(
                  onTap: () {},
                  controller: _controller.controllerNome,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    counterText: _controller.controllerNome.text.length <= 1
                        ? "${_controller.controllerNome.text.length} caracter"
                        : "${_controller.controllerNome.text.length} caracteres",
                    labelText: labelTextNome,
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2)),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    suffixIcon: _controller.controllerNome.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _controller.controllerNome.clear(),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  maxLength: 100,
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  onTap: () {},
                  controller: _controller.controllerSobrenome,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    counterText: _controller.controllerSobrenome.text.length <=
                            1
                        ? "${_controller.controllerSobrenome.text.length} caracter"
                        : "${_controller.controllerSobrenome.text.length} caracteres",
                    labelText: labelTextSobrenome,
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2)),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    suffixIcon: _controller.controllerSobrenome.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () =>
                                _controller.controllerSobrenome.clear(),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  maxLength: 100,
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  onTap: () {},
                  controller:
                      _controller.controllerMaskCpf.textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: _controller.controllerMaskCpf.formatter
                                .getFormatter()
                                .getUnmaskedText()
                                .length <=
                            1
                        ? "${_controller.controllerMaskCpf.formatter.getFormatter().getUnmaskedText().length} caracter"
                        : "${_controller.controllerMaskCpf.formatter.getFormatter().getUnmaskedText().length} caracteres",
                    labelText: labelTextCpf,
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2)),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    suffixIcon: _controller.controllerMaskCpf
                            .textEditingController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _controller
                                .controllerMaskCpf.textEditingController
                                .clear(),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  inputFormatters: [
                    _controller.controllerMaskCpf.formatter.getFormatter()
                  ],
                  maxLength: 100,
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  onTap: () {},
                  controller: _controller
                      .controllerMaskNascimento.textEditingController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    counterText: _controller.controllerMaskNascimento.formatter
                                .getFormatter()
                                .getUnmaskedText()
                                .length <=
                            1
                        ? "${_controller.controllerMaskNascimento.formatter.getFormatter().getUnmaskedText().length} caracter"
                        : "${_controller.controllerMaskNascimento.formatter.getFormatter().getUnmaskedText().length} caracteres",
                    labelText: labelTextNascimento,
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2)),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    suffixIcon: _controller.controllerMaskNascimento
                            .textEditingController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _controller
                                .controllerMaskNascimento.textEditingController
                                .clear(),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  inputFormatters: [
                    _controller.controllerMaskNascimento.formatter
                        .getFormatter()
                  ],
                  maxLength: 100,
                  style: const TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Documento de identificação: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await _controller.documentoDeIdentificacao
                                    .getImageCamera();
                                _controller.documentoDeIdentificacao.descricao =
                                    "documentoDeIdentificacao";
                                if (_controller
                                        .documentoDeIdentificacao.image !=
                                    null) {
                                  _controller.documento = true;
                                }
                              },
                              child: Icon(Icons.add_a_photo,
                                  size: 30,
                                  color: (_controller.documento
                                      ? Colors.green
                                      : Colors.red)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  await _controller.documentoDeIdentificacao
                                      .getImageGallery();
                                  _controller.documentoDeIdentificacao
                                      .descricao = "documentoDeIdentificacao";
                                  if (_controller
                                          .documentoDeIdentificacao.image !=
                                      null) {
                                    _controller.documento = true;
                                  }
                                },
                                child: Icon(Icons.file_upload,
                                    size: 30,
                                    color: (_controller.documento
                                        ? Colors.green
                                        : Colors.red))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(190, 65),
                        elevation: 2,
                        primary: Colors.black,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        _cadastrarPerfilEnviar();
                      },
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
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(190, 65),
                        elevation: 2,
                        foregroundColor: Colors.black,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        _controller.limparCampos();
                      },
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorsLevv.FUNDO_400,
    );
  }
}
