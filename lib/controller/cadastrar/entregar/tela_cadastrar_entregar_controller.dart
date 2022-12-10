import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/api/mascara/formatter_cpf.dart';
import 'package:levv4/api/mascara/formatter_date.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/controller/cadastrar/endereco/tela_cadastrar_endereco_controller.dart';
import 'package:levv4/controller/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte_controller.dart';
import 'package:levv4/controller/cadastrar/nivel_1/cadastro_nivel_1_controller.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

class TelaCadastrarEntregadorController {
  final cadastroNivel1Controller = CadastroNivel1Controller();

  ///Meio de transporte
  ///
  final controllerMeioDeTransportes = TelaCadastrarMeioDeTransporteController();

  /// Endereço
  ///
  final controllerEndereco = TelaCadastrarEnderecoController();

  limparCampos() {
    cadastroNivel1Controller.limparCampos();
    controller.controllerMeioDeTransportes.limparTodosOsCampos();
    controllerEndereco.controllerEndereco.limparTodosOsCampos();
  }

  validarDados() {
    return cadastroNivel1Controller.validador() &&
        controller.controllerEndereco.validador() &&
        controller.controllerMeioDeTransportes.validador();
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
