import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/api/numerador_de_pedido/numerador_de_pedido.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

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
  static const documentSucessfullyRetriveAll =
      "PedidoDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyRetriveAllCities =
      "PedidoDAO: DocumentSnapshot successfully retrive all cities!";
  static const documentSucessfullyRetriveAllCurrentUser =
      "PedidoDAO: DocumentSnapshot successfully retrive all current user!";
  static const documentSucessfullyDelete =
      "PedidoDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "PedidoDAO: Error crete document!";
  static const documentErrorUpdate = "PedidoDAO: Error update document!";
  static const documentErrorRetrive = "PedidoDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "PedidoDAO: Error retrive all document!";
  static const documentErrorRetriveAllCities =
      "PedidoDAO: Error retrive all document cities!";
  static const documentErrorRetriveAllCurrentUser =
      "PedidoDAO: Error retrive all document current user!";
  static const documentErrorDelete = "PedidoDAO: Error delete document!";

  static const documentIsNotExists = "PedidoDAO: não há pedidos do usuário!";
  static const documentIsNotExistsInActualyCity =
      "PedidoDAO: não há pedidos na cidade atual!";

  @override
  Future<void> criar(Pedido object) async {
    try {
      final numeradorDePedido = NumeradorDePedido();
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(numeradorDePedido.converterEmMd5(object.numero!))
          .set(object.toMap());
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
          .update(object.toMap());
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
        res.docs.map((e) {
          pedidos.add(Pedido.fromMap(e.data()));
        });
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

  Future<List<Pedido>> buscarPedidosDoUsuario(
      {required Usuario usuario, int limite = 10}) async {
    List<Pedido> pedidos = [];

    //  DocumentReference documentReferenceUsuarioDonoDoPedido =
    //       FirebaseFirestore.instance.doc(
    //         '${UsuarioDAO.collectionPath}/${nomeDoDocumentoDoUsuarioCorrente()}');

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .where("usuarioDonoDoPedido", isEqualTo: usuario.toMap())
          .orderBy("dataHoraDeCriacaoDoPedido", descending: true)
          .limit(limite)
          .get()
          .then((res) async {
        if (res.docs.isNotEmpty) {
          final Map<String, dynamic> data = {};

          for (DocumentSnapshot documentSnapshot in res.docs) {
            data.addAll(documentSnapshot.data() as Map<String, dynamic>);

            pedidos.add(Pedido.fromMap(data));
          }
        } else {
          print(documentIsNotExists);
        }
      });
      print(documentSucessfullyRetriveAllCurrentUser);
    } catch (erro) {
      print("$documentErrorRetriveAllCurrentUser --> ${erro.toString()}");
    }

    return pedidos;
  }

  @override
  Future<List<Pedido>> buscarPedidosPorCidade(String cidade,
      {required Usuario usuario, int limite = 20}) async {
    List<Pedido> pedidos = [];

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .where("municipioDoPedido", isEqualTo: cidade)
          .where("usuarioDonoDoPedido", isNotEqualTo: usuario.toMap())
          .orderBy("usuarioDonoDoPedido")
          .orderBy("dataHoraDeCriacaoDoPedido", descending: true)
          .limit(limite)
          .snapshots()
          .listen((event) {
            print("Pedido: ");

            pedidos.clear();

            if (event.docs.isNotEmpty) {

              final Map<String, dynamic> data = {};

              for (DocumentSnapshot documentSnapshot in event.docs) {
                data.addAll(documentSnapshot.data() as Map<String, dynamic>);

                pedidos.add(Pedido.fromMap(data));
              }
            } else {
              print(documentIsNotExistsInActualyCity);
            }

      });
      /*
          .then((res) async {
        if (res.docs.isNotEmpty) {

          final Map<String, dynamic> data = {};

          for (DocumentSnapshot documentSnapshot in res.docs) {
            data.addAll(documentSnapshot.data() as Map<String, dynamic>);

            pedidos.add(Pedido.fromMap(data));
          }
        } else {
          print(documentIsNotExistsInActualyCity);
        }
      });
          */
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
/*
  @override
  Map<String, dynamic> toMap(Pedido object) {/*
    DocumentReference documentReferenceUsuarioDonoDoPedido =
        FirebaseFirestore.instance.doc(
            '${UsuarioDAO.collectionPath}/${object.usuarioDonoDoPedido!.celular}');

    final map = {
      if (object.numero != null) "numero": object.numero,
      if (object.valor != null) "valor": object.valor,
      if (object.pedidoEstaDisponivelParaEntrega != null)
        "pedidoEstaDisponivelParaEntrega":
            object.pedidoEstaDisponivelParaEntrega,
      if (object.pedidoFoiEntregue != null)
        "pedidoFoiEntregue": object.pedidoFoiEntregue,
      if (object.pedidoFoiPago != null) "pedidoFoiPago": object.pedidoFoiPago,
      if (object.dataHoraDeCriacaoDoPedido != null)
        "dataHoraDeCriacaoDoPedido": Timestamp.fromMillisecondsSinceEpoch(
            object.dataHoraDeCriacaoDoPedido!.millisecondsSinceEpoch),
      if (object.transporte != null) "transporte": object.transporte,
      if (object.itensDoPedido != null)
        "itensDoPedido": toMapItemDoPedido(object.itensDoPedido!),
      if (object.transportadorDoPedido != null)
        "transportadorDoPedido": object.transportadorDoPedido,
      if (object.usuarioDonoDoPedido != null)
        "usuarioDonoDoPedido": documentReferenceUsuarioDonoDoPedido,
      if (object.volume != null) "volume": object.volume,
      if (object.peso != null) "peso": object.peso,
    };
    return null;
  }

  Map<dynamic, dynamic> toMapItemDoPedido(List<ItemDoPedido> itensDoPedido) {
    final map = {};

    for (ItemDoPedido itemDoPedido in itensDoPedido) {

      map.addAll(itemDoPedido.toMap());
    }

    return map;
  }



  @override
  Pedido fromMap(Map<String, dynamic> map) {

    Timestamp timestamp = map["dataHoraDeCriacaoDoPedido"];
    DateTime dateTime = timestamp.toDate();

    map["itensDoPedido"];

    return Pedido(
      numero: map["numero"],
      valor: map["valor"],
      pedidoEstaDisponivelParaEntrega: map["pedidoEstaDisponivelParaEntrega"],
      pedidoFoiEntregue: map["pedidoFoiEntregue"],
      pedidoFoiPago: map["pedidoFoiPago"],
      dataHoraDeCriacaoDoPedido: dateTime,
      transporte: map["transporte"],
      itensDoPedido: ,
      transportadorDoPedido: map["transportadorDoPedido"],
      usuarioDonoDoPedido: map["usuarioDonoDoPedido"],
      volume: map["volume"],
      peso: map["peso"],
    );
  }

  fromMapItensDoPedido(Map<String, dynamic> map){
    List<ItemDoPedido> itensDoPedido = [];



    ItemDoPedido itemDoPedido = ItemDoPedido(
      ordem: map['ordem'],
      coleta: map['coleta'],
      entrega: map['entrega'],
    );

    itensDoPedido.add(itemDoPedido);

    return itensDoPedido;
  }*/

  List<Pedido> fromListMaps(Map<String, dynamic> map) {
    List<Pedido> listPedidos = [];

    listPedidos = [fromMap(map)];

    //  map.entries.forEach((element) {

    //   final data = {element.key: element.value};

    //   listPedidos.add(fromMap(data));

    // });

    //for (var item in map.values) {
    //for (Map<String,dynamic> _map in map.) {

    //   listPedidos.add(fromMap(_map));
    //  }
    return listPedidos;
  }*/

}
