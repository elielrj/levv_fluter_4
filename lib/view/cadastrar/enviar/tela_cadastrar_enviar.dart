import 'package:flutter/material.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

import 'package:levv4/view/cadastrar/enviar/cadastro_de_perfil_enviar.dart';
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
  final controllerCpf = TextEditingController();
  final controllerNascimento = TextEditingController();
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
    controllerCpf.addListener(() => setState(() {}));
    controllerNascimento.addListener(() => setState(() {}));
  }

  _limparCampos() {
    controllerNome.clear();
    controllerSobrenome.clear();
    controllerCpf.clear();
    controllerNascimento.clear();

    documento = false;
  }

  _cadastrarPerfilEnviar() async {
    if (controllerNome.text.isNotEmpty &&
        controllerSobrenome.text.isNotEmpty &&
        controllerCpf.text.isNotEmpty &&
        controllerNascimento.text.isNotEmpty) {
      if (!documento) {
        _exibirMensagemDeFaltaDeUploadDeDocumento();
      } else {

        Enviar enviar = Enviar(
          nome: controllerNome.text,
          sobrenome: controllerSobrenome.text,
          cpf: controllerCpf.text.toString(),
          nascimento: DateFormat('dd/MM/yyyy').parse(controllerNascimento.text).toLocal(),
          documentoDeIdentificacao: true,
        );

        try {


          final arquivoDAO = ArquivoDAO();
          arquivoDAO.upload(documentoDeIdentificacao);

          final enviarDAO = EnviarDAO();
          await enviarDAO.create(enviar);

          widget.usuario.perfil = enviar;

          final usuarioDAO = UsuarioDAO();
          await usuarioDAO.update(widget.usuario);

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
    Navigator.push(context, //pushReplacement?? ou só push?
        MaterialPageRoute(builder: (context) => TelaEnviar(usuario: usuario)));
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
                CadastroDePerfilEnviar(
                    controller: controllerNome,
                    labelText: labelTextNome,
                    keyboardType: TextInputType.name),
                CadastroDePerfilEnviar(
                    controller: controllerSobrenome,
                    labelText: labelTextSobrenome,
                    keyboardType: TextInputType.name),
                CadastroDePerfilEnviar(
                    controller: controllerCpf,
                    labelText: labelTextCpf,
                    keyboardType: TextInputType.number),
                CadastroDePerfilEnviar(
                    controller: controllerNascimento,
                    labelText: labelTextNascimento,
                    keyboardType: TextInputType.datetime),
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
                                documentoDeIdentificacao.descricao = "documentoDeIdentificacao";

                                if (documentoDeIdentificacao.image != null) {
                                  setState(() {
                                    documento = true;
                                  });
                                }
                              },
                              child: Icon(Icons.add_a_photo,
                                  size: 30,
                                  color:
                                      (documento ? Colors.green : Colors.red)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  documentoDeIdentificacao.getImageGallery();
                                  documentoDeIdentificacao.descricao = "documentoDeIdentificacao";

                                  if (documentoDeIdentificacao.image != null) {
                                    setState(() {
                                      documento = true;
                                    });
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
      backgroundColor: ColorsLevv.FUNDO,
    );
  }
}
