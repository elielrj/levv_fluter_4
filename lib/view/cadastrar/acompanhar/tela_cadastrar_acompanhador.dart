import 'package:flutter/material.dart';
import 'package:levv4/api/codigo_do_pais/codigo_do_pais.dart';
import 'package:levv4/api/criador_de_usuario.dart';
import 'package:levv4/api/mascara/formatter_phone.dart';
import 'package:levv4/api/mascara/formatter_sms.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';

import '../../../api/imagem/image_levv.dart';
import '../../../api/texto/text_levv.dart';

import '../../../api/cor/colors_levv.dart';
import '../../componentes/counter_text/mixin_counter_text.dart';
import '../../componentes/logo/widget_logo_levv.dart';
import '../../home/tela_home.dart';

class TelaCadastrarAcompanhador extends StatefulWidget with CounterText {
  const TelaCadastrarAcompanhador({Key? key}) : super(key: key);

  @override
  State<TelaCadastrarAcompanhador> createState() =>
      _TelaCadastrarAcompanhadorState();
}

class _TelaCadastrarAcompanhadorState extends State<TelaCadastrarAcompanhador> {
  final codigoDoPais = CodigoDoPais();
  final telefone = Mask(formatter: FormatterPhone());
  final sms = Mask(formatter: FormatterSms());
  final criadorDeUsuario = CriadorDeUsuario();

  @override
  void initState() {
    super.initState();
    telefone.textEditingController.addListener(() => setState(() {}));
    sms.textEditingController.addListener(() => setState(() {}));
    criadorDeUsuario.addListener(() => setState(() {}));
  }

  /// 1 - Cadastrar usuário manualmente
  /// 2 - Cadastrar usuário automáticamente

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO_400,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logoLevv(bottom: 32),
                !criadorDeUsuario.smsEnviado

                    /// SMS não enviado
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///Cód País
                              Expanded(child: codigoDoPais.codigoDoPais),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 280,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 18),

                                    ///Campo para telefone
                                    TextField(
                                      controller:
                                          telefone.textEditingController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          counterText:
                                              widget.counterText(telefone),
                                          labelText: TextLevv.CELULAR,
                                          labelStyle: const TextStyle(
                                              backgroundColor: Colors.white,
                                              color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.black12,
                                                  width: 2)),
                                          prefixIcon: const Icon(
                                            Icons.phone_iphone,
                                            color: Colors.black,
                                          ),
                                          suffixIcon: telefone
                                                  .textEditingController
                                                  .text
                                                  .isEmpty
                                              ? Container(width: 0)
                                              : IconButton(
                                                  onPressed: () {
                                                    telefone
                                                        .textEditingController
                                                        .clear();
                                                  },
                                                  icon: const Icon(Icons.close,
                                                      color: Colors.red),
                                                ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText:
                                              telefone.formatter.getHint()),
                                      inputFormatters: [
                                        telefone.formatter
                                            .getMaskTextInputFormatter()
                                      ],
                                      maxLength: 20,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          ///Botão "cadastrar" acompanhador
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              padding: const EdgeInsets.all(0),
                              minimumSize: const Size(180, 65),
                              elevation: 2,
                              foregroundColor: Colors.black,
                              alignment: Alignment.center,
                            ),
                            onPressed: () async => telefone.formatter.isValid()
                                ? await _criarUsuarioAtomaticamente()
                                : _exibirMensagemDeErro(
                                    TextLevv.NUMERO_CELULAR_INVALIDO),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageLevv.REGISTER,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 20),
                                const Text(TextLevv.CADASTRAR)
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(width: 0),
                criadorDeUsuario.smsEnviado

                    /// SMS enviado
                    ? Container(
                        padding: const EdgeInsets.only(top: 32),
                        child: Column(
                          children: [
                            ///Campo p/ digitar código SMS
                            TextField(
                              controller: sms.textEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counterText: widget.counterText(sms),
                                labelText: TextLevv.CODIGO_SMS,
                                labelStyle: const TextStyle(
                                    backgroundColor: Colors.white,
                                    color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black12, width: 2)),
                                prefixIcon: const Icon(
                                  Icons.sms_outlined,
                                  color: Colors.black,
                                ),
                                suffixIcon: sms.formatter
                                        .getMaskTextInputFormatter()
                                        .getUnmaskedText()
                                        .isEmpty
                                    ? Container(width: 0)
                                    : IconButton(
                                        onPressed: () {
                                          //setState(() {
                                          sms.textEditingController.clear();
                                          // });
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              inputFormatters: [
                                sms.formatter.getMaskTextInputFormatter()
                              ],
                              maxLength: 7,
                              style: const TextStyle(fontSize: 14),
                            ),

                            ///Botão enviar o código SMS recebido
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                padding: const EdgeInsets.only(top: 8),
                                minimumSize: const Size(180, 65),
                                elevation: 2,
                                foregroundColor: Colors.black,
                                alignment: Alignment.center,
                              ),
                              onPressed: () => sms.formatter.isValid()
                                  ? _criarUsuarioComCodigoSMS()
                                  : _exibirMensagemDeErro(
                                      TextLevv.ERRO_CODIGO_SMS),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageLevv.REGISTER,
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 20),
                                  const Text(TextLevv.ENVIAR_CODIGO_SMS)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(width: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Cria usuário no app enviando o código SMS automatcamente
  ///e reconhece e criar perfil no banco de dados
  /// 1
  Future<void> _criarUsuarioAtomaticamente() async {
    try {
      await criadorDeUsuario.verifyPhoneNumber(
          codigoDoPais.codigoDoPais.defaultCountryCode.phoneCode +
              telefone.formatter
                  .getMaskTextInputFormatter()
                  .getUnmaskedText()
                  .toString());

      criadorDeUsuario.usuario != null
          ? _navegarParaTelaHome(criadorDeUsuario.usuario)
          : _exibirMensagemDeErro(
              TextLevv.ERRO_SMS_AUTOMATICAMENTE);
    } catch (erro) {
      _exibirMensagemDeErro(erro.toString());
    }
  }

  ///2
  Future<void> _criarUsuarioComCodigoSMS() async {
    try {
      await criadorDeUsuario.criarUsuarioAcompanharPedido(
          codigoDoPais.codigoDoPais.defaultCountryCode.phoneCode +
              telefone.formatter
                  .getMaskTextInputFormatter()
                  .getUnmaskedText()
                  .toString(),
          sms.formatter
              .getMaskTextInputFormatter()
              .getUnmaskedText()
              .toString());

      _navegarParaTelaHome(criadorDeUsuario.usuario);
    } catch (erro) {
      _exibirMensagemDeErro(erro.toString());
    }
  }

  /// 2
  _navegarParaTelaHome(Usuario usuario) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => TelaHome(
                usuario: usuario,
              )));

  /// 1
  /// 2
  _exibirMensagemDeErro(String erro) {
    print('Cadastro de Acompanhador: --> $erro');
    AlertDialog(
      title: const Text(TextLevv.ERRO, textAlign: TextAlign.center),
      content: Text(erro.toString()),
      titlePadding: const EdgeInsets.all(20),
      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(TextLevv.OK))
      ],
    );
  }
}
