import 'package:flutter/material.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';

class DocumentoDeIdentificacao extends StatelessWidget {
  const DocumentoDeIdentificacao({Key? key, required this.documento})
      : super(key: key);

  final Arquivo documento;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///1 Descrição do documento a ser enviado
          Text(
            documento.descricao.toString(),
            style: const TextStyle(fontSize: 20),
          ),

          ///2 campo de busca de imagem p/ subir o documento
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                _buscarImagemDaCameraoSmartphone(),
                const SizedBox(
                  width: 20,
                ),
                _buscarImagemDaGaleriaDeImagemDoSmartphone(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buscarImagemDaGaleriaDeImagemDoSmartphone() => GestureDetector(
      onTap: () async => await documento.getImageGallery(),
      child: Icon(Icons.file_upload,
          size: 30,
          color: (documento.file != null ? Colors.green : Colors.red)));

  Widget _buscarImagemDaCameraoSmartphone() => GestureDetector(
        onTap: () async => await documento.getImageCamera(),
        child: Icon(Icons.add_a_photo,
            size: 30,
            color: (documento.file != null ? Colors.green : Colors.red)),
      );
}
