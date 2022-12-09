import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/pessoa/pessoa.dart';

class Enviar extends Pessoa {
  static const perfil = "Enviar";

  Arquivo? documentoDeIdentificacao;

  Enviar(
      {String? nome,
      String? sobrenome,
      String? cpf,
      DateTime? nascimento,
      List<Endereco>? enderecosFavoritos,
      Endereco? casa,
      Endereco? trabalho,
      this.documentoDeIdentificacao})
      : super(
            nome: nome,
            sobrenome: sobrenome,
            cpf: cpf,
            nascimento: nascimento,
            enderecosFavoritos: enderecosFavoritos,
            casa: casa,
            trabalho: trabalho);

  cadastrarDocumentoDeIdentificacaoFromGallery() async {
    final arquivo = Arquivo(descricao: "documentoDeIdentificacao");

    arquivo.file = await arquivo.getImageGallery();
  }

  cadastrarDocumentoDeIdentificacaoFromCamera() async {
    final arquivo = Arquivo(descricao: "documentoDeIdentificacao");

    arquivo.file = await arquivo.getImageCamera();
  }

  @override
  String exibirPerfil() => perfil;
}
