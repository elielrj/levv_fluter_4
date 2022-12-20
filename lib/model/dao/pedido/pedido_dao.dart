import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';

import 'i_crud_pedido_dao.dart';

class PedidoDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements ICrudPedidoDAO<Pedido> {
  final collectionPath = "pedidos";

  static const documentSucessfullyCreate =
      "PedidoDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "PedidoDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "PedidoDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll = "PedidoDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyRetriveAllCities = "PedidoDAO: DocumentSnapshot successfully retrive all cities!";
  static const documentSucessfullyRetriveAllCurrentUser = "PedidoDAO: DocumentSnapshot successfully retrive all current user!";
  static const documentSucessfullyDelete =
      "PedidoDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "PedidoDAO: Error crete document!";
  static const documentErrorUpdate = "PedidoDAO: Error update document!";
  static const documentErrorRetrive = "PedidoDAO: Error retrive document!";
  static const documentErrorRetriveAll = "PedidoDAO: Error retrive all document!";
  static const documentErrorRetriveAllCities = "PedidoDAO: Error retrive all document cities!";
  static const documentErrorRetriveAllCurrentUser = "PedidoDAO: Error retrive all document current user!";
  static const documentErrorDelete = "PedidoDAO: Error delete document!";

  static const documentIsNotExists = "PedidoDAO: não há pedidos do usuário!";
  static const documentIsNotExistsInActualyCity = "PedidoDAO: não há pedidos na cidade atual!";

  @override
  Future<void> criar(Pedido object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(object.numero)
          .set(toMap(object));
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Pedido object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(object.numero)
          .update(toMap(object));
      print(documentSucessfullyUpdate);
    } catch (erro) {
      print("$documentErrorUpdate--> ${erro.toString()}");
    }
  }

  @override
  Future<List<Pedido>> buscarTodos() async {
    List<Pedido> pedidos = [];

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .get()
          .then((res) {
        res.docs.map((e) => pedidos.add(fromMap(e.data())));
      });
      print(documentSucessfullyRetriveAll);
    } catch (erro) {
      print("$documentErrorRetriveAll --> ${erro.toString()}");
    }

    return pedidos;
  }

/*
  @override
  Future<Pedido?> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(reference).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: ${e.toString()}"),
    );
  }
*/

  Future<List<Pedido>> buscarPedidosDoUsuario({int limite = 10}) async {
    List<Pedido> pedidos = [];

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .where("usuarioDonoDoPedido",
              isEqualTo: nomeDoDocumentoDoUsuarioCorrente())
          .orderBy("dataHoraDeCriacaoDoPedido", descending: true)
          .limit(limite)
          .get()
          .then((res) async {
            if(res.docs.isNotEmpty){
              final data = res as Map<String, dynamic>;

              pedidos = fromListMaps(data);
            }else{
              print(documentIsNotExists);
            }

      });
      print(documentSucessfullyRetriveAllCurrentUser);
    } catch (erro) {
      print("$documentErrorRetriveAllCurrentUser --> ${erro.toString()}");
    }

    return pedidos;
  }

  Future<List<Pedido>> buscarPedidosPorCidade(String cidade,
      {int limite = 20}) async {
    List<Pedido> pedidos = [];

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .where("cidade", isEqualTo: cidade)
          .where("pedidoEstaDisponivelParaEntrega", isEqualTo: true)
          .orderBy("dataHoraDeCriacaoDoPedido", descending: true)
          .limit(limite)
          .get()
          .then((res) async {

            if(res.docs.isNotEmpty){
              final data = res as Map<String, dynamic>;

              pedidos = fromListMaps(data);
            }else{
              print(documentIsNotExistsInActualyCity);
            }

      });
      print(documentSucessfullyRetriveAllCities);
    } catch (erro) {
      print("$documentErrorRetriveAllCities--> ${erro.toString()}");
    }

    return pedidos;
  }

  @override
  Future<void> deletar(Pedido object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(object.numero)
          .delete();
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete ${erro.toString()}");
    }
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

  List<Pedido> fromListMaps(Map<String, dynamic> map) {
    List<Pedido> listPedidos = [];

    for (var item in map.values) {
      listPedidos.add(fromMap(item));
    }
    return listPedidos;
  }
}
