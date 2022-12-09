import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/api/mascara/formatter_cpf.dart';
import 'package:levv4/api/mascara/formatter_date.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/controller/cadastrar/endereco/tela_cadastrar_endereco_controller.dart';
import 'package:levv4/controller/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte_controller.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

class TelaCadastrarEntregadorController {
  final controllerMeioDeTransportes = TelaCadastrarMeioDeTransporteController();
  final controllerEndereco = TelaCadastrarEnderecoController();

  final controllerNome = TextEditingController();
  final controllerSobrenome = TextEditingController();
  final controllerMaskCpf = Mask(formatter: FormatterCpf());
  final controllerMaskNascimento = Mask(formatter: FormatterDate());
  final documentoDeIdentificacao = Arquivo();

  limparTodosOsCampos() {
    controllerNome.clear();
    controllerSobrenome.clear();
    controllerMaskCpf.textEditingController.clear();
    controllerMaskNascimento.textEditingController.clear();
    documentoDeIdentificacao.file = null;
  }

  bool validador() {
    return validarNome() &
        validarSobrenome() &
        validarCpf() &
        validarDataNascimento() &
        validarDocumentoDeIdentificacao();
  }

  bool validarNome() {
    return controllerNome.text.isNotEmpty;
  }

  bool validarSobrenome() {
    return controllerSobrenome.text.isNotEmpty;
  }

  bool validarCpf() {
    return controllerMaskCpf.formatter
        .isValid();
  }

  bool validarDataNascimento() {
    return controllerMaskNascimento.formatter
        .isValid();
  }

  bool validarDocumentoDeIdentificacao() {
    return documentoDeIdentificacao.file != null;
  }

  Entregar montarObjetoEntregar() => Entregar(
        nome: controllerNome.text.toString(),
        sobrenome: controllerSobrenome.text.toString(),
        cpf: controllerMaskCpf.formatter
            .getMaskTextInputFormatter()
            .getUnmaskedText()
            .toString(),
        nascimento: DateFormat('dd/MM/yyyy')
            .parse(controllerMaskNascimento.textEditingController.text),
        casa: montarObjetoEnderecoCasa(),
        documentoDeIdentificacao: documentoDeIdentificacao,
        meioDeTransporte: montarObjetoMeioDeTransporte(),
      );

  Endereco montarObjetoEnderecoCasa() => Endereco(
        logradouro: controllerEndereco.logradouro.text.toString(),
        numero: controllerEndereco.numero.toString(),
        complemento: controllerEndereco.complemento.text.toString(),
        cep: controllerEndereco.cepMask.formatter
            .getMaskTextInputFormatter()
            .getUnmaskedText(),
        geolocalizacao: controllerEndereco.geoPoint,
        bairro: controllerEndereco.bairro.text.toString(),
        cidade: controllerEndereco.cidade.text.toString(),
        estado: controllerEndereco.estado.text.toString(),
      );

  MeioDeTransporte montarObjetoMeioDeTransporte() {
    return controllerMeioDeTransportes.meioDeTransporteSelecionado();
  }

  Future<void> atualizarCadastroDOUsuarioComPerfilDeEntregador(
      Usuario usuario) async {
    //atualizar Usuario e criar perfil atual
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.atualizar(usuario);
  }
}
