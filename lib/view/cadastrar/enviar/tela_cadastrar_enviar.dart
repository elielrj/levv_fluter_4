import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
import 'package:levv4/model/frontend/mask/masks_levv.dart';

import 'package:levv4/view/enviar/tela_enviar.dart';

import '../../../model/bo/arquivo/arquivo.dart';
import '../../../model/bo/usuario/perfil/enviar/enviar.dart';
import '../../../model/frontend/colors_levv.dart';

import 'package:intl/intl.dart';

class TelaCadastrarCliente extends StatefulWidget {
  const TelaCadastrarCliente({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;

  @override
  State<TelaCadastrarCliente> createState() => _TelaCadastrarClienteState();
}

class _TelaCadastrarClienteState extends State<TelaCadastrarCliente> {
  final controllerNome = TextEditingController();
  final controllerSobrenome = TextEditingController();
  final controllerMaskCpf = MasksLevv.cpfMask;
  final controllerMaskNascimento = MasksLevv.dateMask;
  final documentoDeIdentificacao = Arquivo();

  String labelTextNome = "Nome";
  String labelTextSobrenome = "Sobrenome";
  String labelTextCpf = "Cpf";
  String labelTextNascimento = "Data de Nascimento";
  bool documento = false;

  @override
  void initState() {
    super.initState();
    controllerNome.addListener(() => setState(() {}));
    controllerSobrenome.addListener(() => setState(() {}));
    controllerMaskCpf.textEditingController.addListener(() => setState(() {}));
    controllerMaskNascimento.textEditingController.addListener(() => setState(() {}));
    documento;
    widget.usuario;
  }

  _limparCampos() {
    controllerNome.clear();
    controllerSobrenome.clear();
    controllerMaskCpf.textEditingController.clear();
    controllerMaskNascimento.textEditingController.clear();

    documento = false;

  }

  _cadastrarPerfilEnviar() async {
    if (controllerNome.text.isNotEmpty &&
        controllerSobrenome.text.isNotEmpty &&
        controllerMaskCpf.textEditingController.text.isNotEmpty &&
        controllerMaskNascimento.textEditingController.text.isNotEmpty) {
      if (!documento) {
        _exibirMensagemDeFaltaDeUploadDeDocumento();
      } else {
        Enviar enviar = Enviar(
          nome: controllerNome.text,
          sobrenome: controllerSobrenome.text,
          cpf: controllerMaskCpf.textEditingController.text.toString(),
          nascimento: DateFormat('dd/MM/yyyy')
              .parse(controllerMaskNascimento.textEditingController.text)
              .toLocal(),
          documentoDeIdentificacao: true,
        );

        try {
          final arquivoDAO = ArquivoDAO();
          arquivoDAO.upload(documentoDeIdentificacao);

          final enviarDAO = EnviarDAO();
          await enviarDAO.create(enviar);

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
        MaterialPageRoute(builder: (context) => TelaEnviar(usuario: usuario, pedido: Pedido(),)));
  }

  _exibirMensagemDeFaltaDeUploadDeDocumento() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Campo Vazio"),
            titlePadding: EdgeInsets.all(20),
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
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: const Text(
                "Varifique os dados digitados, pois há 1 ou mais campos vazios!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
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
                  controller: controllerNome,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    counterText: controllerNome.text.length <= 1
                        ? "${controllerNome.text.length} caracter"
                        : "${controllerNome.text.length} caracteres",
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
                    suffixIcon: controllerNome.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => controllerNome.clear(),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  maxLength: 100,
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  onTap: () {},
                  controller: controllerSobrenome,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    counterText: controllerSobrenome.text.length <= 1
                        ? "${controllerSobrenome.text.length} caracter"
                        : "${controllerSobrenome.text.length} caracteres",
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
                    suffixIcon: controllerSobrenome.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => controllerSobrenome.clear(),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  maxLength: 100,
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  onTap: () {},
                  controller: controllerMaskCpf.textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: controllerMaskCpf
                                .formatter.getUnmaskedText().length <=
                            1
                        ? "${controllerMaskCpf.formatter.getUnmaskedText().length} caracter"
                        : "${controllerMaskCpf.formatter.getUnmaskedText().length} caracteres",
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
                    suffixIcon: controllerMaskCpf
                            .textEditingController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () =>
                                controllerMaskCpf.textEditingController.clear(),
                          ),

                    fillColor: Colors.white,
                    filled: true,
                  ),
                  inputFormatters: [controllerMaskCpf.formatter],
                  maxLength: 100,
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  onTap: () {},
                  controller: controllerMaskNascimento.textEditingController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    counterText: controllerMaskNascimento.formatter.getUnmaskedText().length <= 1
                        ? "${controllerMaskNascimento.formatter.getUnmaskedText().length} caracter"
                        : "${controllerMaskNascimento.formatter.getUnmaskedText().length} caracteres",
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
                    suffixIcon: controllerMaskNascimento.textEditingController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => controllerMaskNascimento.textEditingController.clear(),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  inputFormatters: [controllerMaskNascimento.formatter],
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
                              onTap: () {
                                documentoDeIdentificacao.getImageCamera();
                                documentoDeIdentificacao.descricao =
                                    "documentoDeIdentificacao";
                                if(documentoDeIdentificacao.image != null){
                                  documento = true;
                                }
                              },
                              child: Icon(Icons.add_a_photo,
                                  size: 30,
                                  color:
                                      (documento
                                          ? Colors.green
                                          : Colors.red)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  documentoDeIdentificacao.getImageGallery();
                                  documentoDeIdentificacao.descricao =
                                      "documentoDeIdentificacao";
                                  if(documentoDeIdentificacao.image != null){
                                    documento = true;
                                  }
                                },
                                child: Icon(Icons.file_upload,
                                    size: 30,
                                    color: (documento
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
                        primary: Colors.black,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        _limparCampos();
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
