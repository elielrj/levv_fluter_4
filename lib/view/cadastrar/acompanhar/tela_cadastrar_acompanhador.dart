import 'package:flutter/material.dart';

import '../../../api/imagem/image_levv.dart';
import '../../../api/texto/text_levv.dart';
import '../../../controller/cadastrar/acompanhar/tela_cadastrar_acompanhar_controller.dart';

import '../../../api/cor/colors_levv.dart';
import '../../componentes/counter_text/mixin_counter_text.dart';
import '../../componentes/logo/widget_logo_levv.dart';
import '../../home/tela_home.dart';

class TelaCadastrarAcompanhador extends StatefulWidget with CounterText {
  const TelaCadastrarAcompanhador({Key? key}) : super(key: key);

  @override
  State<TelaCadastrarAcompanhador> createState() => _TelaCadastrarAcompanhadorState();
}

class _TelaCadastrarAcompanhadorState extends State<TelaCadastrarAcompanhador> {
  final TelaCadastrarAcompanharController _controller = TelaCadastrarAcompanharController();

  @override
  void initState() {
    super.initState();

    _controller.telefone.textEditingController.addListener(() => setState(() {}));
    _controller.sms.textEditingController.addListener(() => setState(() {}));
  }

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
                !_controller.smsEnviado

                    /// SMS não enviado
                    ? _smsNaoEnviado()
                    : Container(width: 0),
                _controller.smsEnviado

                    /// SMS enviado
                    ? _smsEnviado()
                    : Container(width: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _verificarSeExisteUsuarioNoBancoENavegarParaTelaHome() async {
    if (!await _controller.verificarSeExisteUsuarioNoBanco()) {
      await _controller.cadastrarUsuarioNoBanco();
    }

    _navegarParaTelaHome();
  }

  _navegarParaTelaHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario: _controller.usuario!,
                )));
  }

  ///Campo p/ digitar o código SMS
  ///
  _textFieldCodigoSMS() => TextField(
        controller: _controller.sms.textEditingController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: widget.counterText(_controller.sms),
          labelText: TextLevv.CODIGO_SMS,
          labelStyle: const TextStyle(backgroundColor: Colors.white, color: Colors.black),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black12, width: 2)),
          prefixIcon: const Icon(
            Icons.sms_outlined,
            color: Colors.black,
          ),
          suffixIcon: _controller.sms.formatter.getMaskTextInputFormatter().getUnmaskedText().isEmpty
              ? Container(width: 0)
              : IconButton(
                  onPressed: () {
                    //setState(() {
                    _controller.sms.textEditingController.clear();
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
        inputFormatters: [_controller.sms.formatter.getMaskTextInputFormatter()],
        maxLength: 7,
        style: const TextStyle(fontSize: 14),
      );

  _textButtonCodigoSMS() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.only(top: 8),
          minimumSize: const Size(180, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () async => await _criarUsuarioComCodigoSMS(),
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
      );

  _criarUsuarioComCodigoSMS() async {
    try {
      await _controller.criarUsuarioComCodigoSMS();

      //navegar p/ Tela Home
      if (_controller.existeUmUsuarioCorrente()) {
        /// Navegar p/ Tela Home c/ verificação de usuário no banco de Dados
        await _verificarSeExisteUsuarioNoBancoENavegarParaTelaHome();
      }
    } catch (erro) {
      AlertDialog(
        title: const Text("Não foi possível confirmar o código", textAlign: TextAlign.center),
        content: Text(erro.toString()),
        titlePadding: const EdgeInsets.all(20),
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
      );
      print('tela cadastrar acompanhador, método _criarUsuarioComCodigoSMS(): --> ${erro.toString()}');
    }
  }

  ///Cria usuário no app enviando o código SMS automatcamente
  ///e reconhece e criar perfil no banco de dados
  ///
  _criarUsuarioAtomaticamente() async {
    try {
      //verificar se o número tel é válido
      bool valido = _controller.numeroDeCelularEstaValido();

      //verificar telefone
      if (valido) {
        await _controller.verifyPhoneNumber();

        /// Navegar p/ Tela Home c/ verificação de usuário no banco de Dados
        await _verificarSeExisteUsuarioNoBancoENavegarParaTelaHome();
      }
    } catch (erro) {
      AlertDialog(
        title: const Text("Não foi possível confirmar o código", textAlign: TextAlign.center),
        content: Text(erro.toString()),
        titlePadding: const EdgeInsets.all(20),
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
      );
      print('tela cadastrar acompanhador, método _criarUsuarioAtomaticamente(): --> ${erro.toString()}');
    }
  }

  ///Campo TexField para inserir o telefone
  ///
  _textFieldAntesDoEnvioDoCodigoSMS() => TextField(
        controller: _controller.telefone.textEditingController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            counterText: widget.counterText(_controller.telefone),
            labelText: TextLevv.CELULAR,
            labelStyle: const TextStyle(backgroundColor: Colors.white, color: Colors.black),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black12, width: 2)),
            prefixIcon: const Icon(
              Icons.phone_iphone,
              color: Colors.black,
            ),
            suffixIcon: _controller.telefone.textEditingController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    onPressed: () {
                      _controller.telefone.textEditingController.clear();
                    },
                    icon: const Icon(Icons.close, color: Colors.red),
                  ),
            fillColor: Colors.white,
            filled: true,
            hintText: _controller.telefone.formatter.getHint()),
        inputFormatters: [_controller.telefone.formatter.getMaskTextInputFormatter()],
        maxLength: 20,
        style: const TextStyle(fontSize: 18),
      );

  ///Campo para código do País
  ///
  _campoParaCodigoDoPais() => Expanded(child: _controller.codigoDoPais.codigoDoPais);

  ///Botao cadastrar Nr Celular
  ///
  _textButtonCadastrarAcompanhador() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () async => await _criarUsuarioAtomaticamente(),
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
      );

  ///Campo SMS enviado
  ///
  _smsEnviado() => Container(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            ///Campo p/ digitar código SMS
            _textFieldCodigoSMS(),

            ///Botão enviar o código SMS recebido
            _textButtonCodigoSMS(),
          ],
        ),
      );

  ///Campo SMS não enviado
  ///
  _smsNaoEnviado() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Cód País
              _campoParaCodigoDoPais(),
              const SizedBox(width: 8),
              SizedBox(
                width: 280,
                child: Column(
                  children: [
                    const SizedBox(height: 18),

                    ///Campo para telefone
                    _textFieldAntesDoEnvioDoCodigoSMS(),
                  ],
                ),
              ),
            ],
          ),

          ///Botão "cadastrar" acompanhador
          _textButtonCadastrarAcompanhador(),
        ],
      );
}
