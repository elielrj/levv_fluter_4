import 'package:flutter_test/flutter_test.dart';
import 'package:levv4/model/bo/pedido/endereco/bairro/cidade/estado/estado.dart';

void main() {
  final estado = Estado("SanTa catarinA", "uF");

  test("Teste da Classe Estado, com a função nome:", () {
    expect(estado.nome, "Santa Catarina");
  });
  test("Teste da Classe Estado, com a função uf:", () {
    expect(estado.uf, "SC");
  });
}
