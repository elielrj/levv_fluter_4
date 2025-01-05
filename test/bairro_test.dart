import 'package:flutter_test/flutter_test.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/bairro.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/cidade/cidade.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/cidade/estado/estado.dart';

void main() {
  final estado = Estado("SanTa catarinA", "uF");
  final cidade = Cidade("tuBarÂo", estado);
  final bairro = Bairro("CenTrO", cidade);

  group("Teste da Classe Bairro: ", () {
    test("Nome do Bairro", () {
      expect(bairro.nome, "cenTrO");
    });

    test("Nome da Cidade: ", () {
      expect(bairro.daCidade, "TUbaRão");
    });

    test("Nome da estado: ", () {
      expect(bairro.doEstado, "Santa Catarina");
    });

    test("Nome da UF: ", () {
      expect(bairro.daUF, "SC");
    });
  });
}
