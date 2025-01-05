import 'package:flutter_test/flutter_test.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/cidade/cidade.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/cidade/estado/estado.dart';

void main() {
  final estado = Estado("SanTa catarinA", "uF");
  final cidade = Cidade("tuBarÂo", estado);

  group("Teste da Classe Cidade:", () {
    test("Nome da Cidade: ", () {
      expect(cidade.nome, "Tubarão");
    });

    test("Nome do Estado: ", () {
      expect(cidade.pertencenteAoEstado, "Santa Catarina");
    });

    test("UF: ", () {
      expect(cidade.daUF, "SC");
    });
  });
}
