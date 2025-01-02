import 'package:levv4/model/bo/perfil/perfil.dart';
@deprecated
class Acompanhar implements Perfil {
  String perfil;

  Acompanhar({this.perfil = "Acompanhar"});

  @override
  String exibirPerfil() => perfil;

  @override
  Map<String, dynamic> toMap() {
    return Map.from({'perfil': perfil});
  }

  @override
  factory Acompanhar.fromMap(Map<String, dynamic> map) {
    return Acompanhar(perfil: map['perfil']);
  }
}
