
import 'package:levv4/model/bo/usuario/perfil/perfil.dart';

class Acompanhar implements Perfil{

  String? perfil;

  Acompanhar(){
    perfil = "Acompanhar";
  }

  @override
  exibirPerfil() {
    return perfil;
  }

}