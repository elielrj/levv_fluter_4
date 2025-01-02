import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/pessoa/pessoa.dart';

@deprecated
class Enviar extends Pessoa {
  Arquivo? documentoDeIdentificacao;

  Enviar(
      {String? nome,
      String? sobrenome,
      String? cpf,
      DateTime? nascimento,
      List<Endereco>? enderecosFavoritos,
      Endereco? casa,
      Endereco? trabalho,
      String perfil = "Enviar",
      this.documentoDeIdentificacao})
      : super(
            perfil: perfil,
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
  String exibirPerfil() => perfil!;

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      if (perfil != null) 'perfil': perfil,
      if (nome != null) 'nome': nome,
      if (sobrenome != null) 'sobrenome': sobrenome,
      if (cpf != null) 'cpf': cpf,
      if (nascimento != null)
        'nascimento': Timestamp.fromMillisecondsSinceEpoch(
            nascimento!.millisecondsSinceEpoch),
      if (enderecosFavoritos != null)
        'enderecosFavoritos': enderecosFavoritos!.asMap(),
      //todo ver como se comporta
      if (casa != null) 'casa': casa!.toMap(),
      if (trabalho != null) 'trabalho': trabalho!.toMap(),
    });
  }

  @override
  factory Enviar.fromMap(Map<dynamic, dynamic> map) {
    Timestamp timestamp = map['nascimento'];

    List<Endereco> enderecosFavoritos = [];
    Map<String, dynamic> enderecos = map['enderecosFavoritos'] ?? {};
    if (enderecos.isNotEmpty) {
      enderecos.values.forEach((element) {
        enderecosFavoritos.add(Endereco.fromMap(element));
      });
    }

    Endereco casa = Endereco();
    Map<String, dynamic> casaMap = map['casa'] ?? {};
    if (casaMap.isNotEmpty) {
      casa = Endereco.fromMap(casaMap);
    }

    Endereco trabalho = Endereco();
    Map<String, dynamic> trabalhoMap = map['trabalho'] ?? {};
    if (casaMap.isNotEmpty) {
      trabalho = Endereco.fromMap(trabalhoMap);
    }

    return Enviar(
      perfil: map['perfil'],
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      cpf: map['cpf'],
      nascimento: timestamp.toDate(),
      enderecosFavoritos: enderecosFavoritos,
      casa: casa,
      trabalho: trabalho,
    );
  }
}
