import 'package:flutter/cupertino.dart';
import 'package:levv4/api/texto/text_banco_de_dados.dart';
import 'package:levv4/model/bo/acompanhar/acompanhar.dart';
import 'package:levv4/model/bo/administrar/administrar.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/map/interface_map.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/perfil/perfil.dart';

class Usuario extends ChangeNotifier implements InterfaceMap {
  String? celular;

  Perfil? perfil;
  List<Pedido>? listaDePedidos;

  Usuario({this.celular, this.perfil, this.listaDePedidos});

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      if (celular != null) TextBancoDeDados.CELULAR: celular,
      if (perfil != null) TextBancoDeDados.PERFIL: perfil!.toMap(),
    });
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    Perfil perfil;

    if (map['perfil']['perfil'] == 'Entregar') {
      perfil = Entregar.fromMap(map['perfil']);
    } else if (map['perfil']['perfil'] == 'Administrar') {
      perfil = Administrar.fromMap(map['perfil']);
    } else if (map['perfil']['perfil'] == 'Enviar') {
      perfil = Enviar.fromMap(map['perfil']);
    } else {
      perfil = Acompanhar.fromMap(map['perfil']);
    }

    return Usuario(
      celular: map['celular'],
      perfil: perfil,
      listaDePedidos: null,
    );
  }

  List<Pedido> listarPedidosAtivos() {
    List<Pedido> ativos = [];

    if (listaDePedidos != null) {
      for (Pedido pedido in listaDePedidos!) {
        if (!pedido.pedidoFoiEntregue! &&
            !pedido.pedidoFoiPago! &&
            !pedido.pedidoEstaDisponivelParaEntrega!) {
          ativos.add(pedido);
        }
      }
    }
    return ativos;
  }

  List<Pedido> listarPedidosFinalizados() {
    List<Pedido> finalizados = [];
    if (listaDePedidos != null) {
      for (Pedido pedido in listaDePedidos!) {
        if (pedido.pedidoFoiEntregue! &&
            pedido.pedidoFoiPago! &&
            !pedido.pedidoEstaDisponivelParaEntrega!) {
          finalizados.add(pedido);
        }
      }
    }

    return finalizados;
  }

  List<Pedido> listarPedidosPendentes() {
    List<Pedido> pendentes = [];

    if (listaDePedidos != null) {
      for (Pedido pedido in listaDePedidos!) {
        if (!pedido.pedidoFoiEntregue! &&
            !pedido.pedidoFoiPago! &&
            pedido.pedidoEstaDisponivelParaEntrega!) {
          pendentes.add(pedido);
        }
      }
    }

    return pendentes;
  }
}
