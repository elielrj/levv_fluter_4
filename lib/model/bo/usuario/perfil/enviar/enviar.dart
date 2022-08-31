import 'package:levv4/model/bo/usuario/perfil/perfil.dart';
import 'package:levv4/model/bo/usuario/perfil/enviar/pessoa.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';

import '../../../arquivo/arquivo.dart';
import '../../../endereco/endereco.dart';

class Enviar extends Pessoa {

  bool? documentoDeIdentificacao;

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
            trabalho: trabalho){
    perfil = "Enviar";
  }


  cadastrarDocumentoDeIdentificacaoFromGallery() async {

    final arquivo = Arquivo(descricao: "documentoDeIdentificacao");

    arquivo.image = await arquivo.getImageGallery();

    final arquivoDAO = ArquivoDAO();

    arquivoDAO.upload(arquivo);

  }

  cadastrarDocumentoDeIdentificacaoFromCamera() async {

    final arquivo = Arquivo(descricao: "documentoDeIdentificacao");

    arquivo.image = await arquivo.getImageCamera();

    final arquivoDAO = ArquivoDAO();

    arquivoDAO.upload(arquivo);

  }

}
