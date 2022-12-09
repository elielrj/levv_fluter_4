

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/perfil/perfil.dart';

abstract class InterfacePerfilDAO {

  Future<void> criar(Perfil perfil);

  Future<void> atualizar(Perfil perfil);

  Future<Perfil> buscar();

  Future<Perfil> buscarComDocumentReference(DocumentReference documentReference);

  Future<void> deletar(Perfil perfil);
}
