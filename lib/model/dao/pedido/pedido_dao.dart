import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/backend/firebase/firestore/bando_de_dados.dart';
import 'package:levv4/model/backend/firebase/firestore/interface/crud_firebase_firestore.dart';


class PedidoDAO implements CrudFirebaseFirestore<Pedido> {
  final bancoDeDados = BancoDeDados(FirebaseFirestore.instance);

  final collectionPath = "pedidos";

  @override
  Future<void> create(Pedido object) async {
    await bancoDeDados.db
        .collection(collectionPath)
        .doc(object.numero)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> update(Pedido object) async {
    await bancoDeDados.db
        .collection(collectionPath)
        .doc(object.numero)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Pedido?> retriveAll() async {
    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Future<Pedido?> searchByReference(String reference) async {
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
  }

  @override
  Future<void> delete(Pedido object) async {
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
