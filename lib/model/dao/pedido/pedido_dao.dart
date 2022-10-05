import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';

import '../meio_de_transporte/i_crud_meio_de_transporte_dao.dart';


class PedidoDAO implements ICrudMeioDeTransporteDAO<Pedido> {
  final bancoDeDados = BancoDeDados();

  final collectionPath = "pedidos";

  @override
  Future<void> criar(Pedido object) async {
    await bancoDeDados.db
        .collection(collectionPath)
        .doc(object.numero)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Pedido object) async {
    await bancoDeDados.db
        .collection(collectionPath)
        .doc(object.numero)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Pedido?> buscarTodos() async {
    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Future<Pedido?> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {
    await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<List<Pedido>?> buscarPedidosDoUsuario(String celular) async {
    await bancoDeDados
        .db
        .collection(collectionPath)
        .where("usuarioDonoDoPedido", isEqualTo: celular)
        .orderBy("dataHoraDeCriacaoDoPedido", descending: true)
        .limit(10)
        .get()
        .then(
          (res) async {

        final data = res as Map<String, dynamic>;

        return fromListMaps(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );

    //todo W/Firestore( 1800): (24.2.1) [Firestore]: Listen for Query(target=Query(pedidos where usuarioDonoDoPedido==+5548988302492 order by -dataHoraDeCriacaoDoPedido, -__name__);limitType=LIMIT_TO_FIRST) failed: Status{code=FAILED_PRECONDITION, description=The query requires an index. You can create it here: https://console.firebase.google.com/v1/r/project/levv4-35095/firestore/indexes?create_composite=Cktwcm9qZWN0cy9sZXZ2NC0zNTA5NS9kYXRhYmFzZXMvKGRlZmF1bHQpL2NvbGxlY3Rpb25Hcm91cHMvcGVkaWRvcy9pbmRleGVzL18QARoXChN1c3VhcmlvRG9ub0RvUGVkaWRvEAEaHQoZZGF0YUhvcmFEZUNyaWFjYW9Eb1BlZGlkbxACGgwKCF9fbmFtZV9fEAI, cause=null}
    //todo I/flutter ( 1800): Error getting document: [cloud_firestore/failed-precondition] The query requires an index. You can create it here: https://console.firebase.google.com/v1/r/project/levv4-35095/firestore/indexes?create_composite=Cktwcm9qZWN0cy9sZXZ2NC0zNTA5NS9kYXRhYmFzZXMvKGRlZmF1bHQpL2NvbGxlY3Rpb25Hcm91cHMvcGVkaWRvcy9pbmRleGVzL18QARoXChN1c3VhcmlvRG9ub0RvUGVkaWRvEAEaHQoZZGF0YUhvcmFEZUNyaWFjYW9Eb1BlZGlkbxACGgwKCF9fbmFtZV9fEAI
  }

  Future<List<Pedido>?> buscarPedidoPorCidade(String cidade) async {
    await bancoDeDados.db.collection(collectionPath)
        .where("cidade", isEqualTo: cidade)
        .orderBy("dataHoraDeCriacaoDoPedido", descending:  true)
        .limit(10)
        .get()
        .then((res) async {
          final data = res as Map<String,dynamic>;

          return fromListMaps(data);

    }, onError: (e) => print("Error getting documents: $e"),
    );

  }

  @override
  Future<void> deletar(Pedido object) async {
    await bancoDeDados.db
        .collection(collectionPath)
        .doc(object.numero)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  Map<String, dynamic> toMap(Pedido object) {
    return {
      if (object.numero != null) "numero": object.numero,
      if (object.valor != null) "valor": object.valor,
      if (object.pedidoEstaDisponivelParaEntrega != null)
        "pedidoEstaDisponivelParaEntrega":
            object.pedidoEstaDisponivelParaEntrega,
      if (object.pedidoFoiEntregue != null)
        "pedidoFoiEntregue": object.pedidoFoiEntregue,
      if (object.pedidoFoiPago != null) "pedidoFoiPago": object.pedidoFoiPago,
      if (object.dataHoraDeCriacaoDoPedido != null)
        "pedidoFoiPago": object.dataHoraDeCriacaoDoPedido,
      if (object.transporte != null) "transporte": object.transporte,
      if (object.itensDoPedido != null) "itensDoPedido": object.itensDoPedido,
      if (object.transportadorDoPedido != null)
        "transportadorDoPedido": object.transportadorDoPedido,
      if (object.usuarioDonoDoPedido != null)
        "usuarioDonoDoPedido": object.usuarioDonoDoPedido,
      if (object.volume != null) "volume": object.volume,
      if (object.peso != null) "peso": object.peso,
    };
  }

  @override
  Pedido fromMap(Map<String, dynamic> map) {
    return Pedido(
      numero: map["numero"],
      valor: map["valor"],
      pedidoEstaDisponivelParaEntrega: map["pedidoEstaDisponivelParaEntrega"],
      pedidoFoiEntregue: map["pedidoFoiEntregue"],
      pedidoFoiPago: map["pedidoFoiPago"],
      dataHoraDeCriacaoDoPedido: map["dataHoraDeCriacaoDoPedido"],
      transporte: map["transporte"],
      itensDoPedido: map["itensDoPedido"],
      transportadorDoPedido: map["transportadorDoPedido"],
      usuarioDonoDoPedido: map["usuarioDonoDoPedido"],
      volume: map["volume"],
      peso: map["peso"],
    );
  }

  List<Pedido>? fromListMaps(Map<String, dynamic> map) {

    List<Pedido> listPedidos = [];

    for ( var item in map.values){
      listPedidos.add(fromMap(item));
    }
    return listPedidos;
  }
}
