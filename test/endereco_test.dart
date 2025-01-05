import 'package:flutter_test/flutter_test.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/bairro.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/cidade/cidade.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/cidade/estado/estado.dart';
import 'package:levv4/model/bo/pedido/endereco/endereco.dart';

void main() {
  final estado = Estado("SanTa catarinA", "uF");
  final cidade = Cidade("tuBarÂo", estado);
  final bairro = Bairro("CenTrO", cidade);
  final endereco = Endereco(bairro, "Rua Coronel Cabral", "Apt 704", "458");

  group("Teste da Classe Endereco:", () {
    test("Nome do Número: ", () {
      expect(endereco.numero, "458");
    });

    test("Nome do Complemento: ", () {
      expect(endereco.complemento, "Apt 704");
    });

    test("Nome da Logradouro: ", () {
      expect(endereco.logradouro, "Rua Coronel Cabral");
    });

    test("Nome do Bairro: ", () {
      expect(endereco.bairro, "Centro");
    });
    test("Nome do Cidade: ", () {
      expect(endereco.cidade, "Tubarão");
    });

    test("Nome do estado: ", () {
      expect(endereco.estado, "Santa Catarina");
    });

    test("Nome do UF: ", () {
      expect(endereco.daUF, "SC");
    });

    test("Etiqueta de endereço:", () {
      expect(
          endereco.enderecoNoFormatoDeImpressaoDeCarta,
          "Rua Coronel Cabral, Nr 458, Apt 704, Centro\n"
          "Tubarão, Santa Catarina - SC");
    });
  });
}
