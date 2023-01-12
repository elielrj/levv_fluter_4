import 'package:levv4/model/bo/acompanhar/acompanhar.dart';

class Administrar extends Acompanhar {
  Administrar({
    String perfil = "Administrar"
  }) : super(perfil: perfil);

  @override
  String exibirPerfil() => perfil!;

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      'perfil': perfil,
    });
  }

  @override
  factory Administrar.fromMap(Map<String, dynamic> map) {
    return Administrar(
      perfil: map['perfil'],
    );
  }
}
