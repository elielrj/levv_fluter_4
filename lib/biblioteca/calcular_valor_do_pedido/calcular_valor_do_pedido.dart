
import 'package:levv4/biblioteca/calcular_distancia_do_pedido/calcular_distancia_do_pedido.dart';

import '../../model/bo/pedido/item_do_pedido.dart';
import '../../model/bo/pedido/pedido.dart';

class CalcularValorDoPedido {
  Pedido pedido;

  CalcularValorDoPedido(this.pedido);

  double calcular() {
    ///1 - Calcula valor total da distância do pedido
    ///
    double distancia = 0.0;
    for (ItemDoPedido item in pedido.itensDoPedido!) {
      distancia +=
          CalcularDistaciaDoPedido.calcularDistancia(itemDoPedido: item);
    }

    ///2 - Fórmula de custo da entrega:
    /// 5,00 => valor mín
    /// 1.6 por Km
    ///
    double y = ((1.6 * distancia) + 5);

    ///3 - Recupera os valores de: volume, peso e qtd
    ///
    double volume = pedido.volume! / 10;
    int quantidade = pedido.itensDoPedido!.length;
    double peso = pedido.peso! / 100;

    ///4 - Calculo do falor final
    ///levando em consideração as variáveis: volume, qtd e peso
    ///
    double valorFinal = y * (volume + quantidade + peso);

    ///5 - Retornar o valor formatado, sem dizima e com precisão de 2 casas decimais
    ///
    return double.parse(valorFinal.toStringAsPrecision(2));
  }
}
