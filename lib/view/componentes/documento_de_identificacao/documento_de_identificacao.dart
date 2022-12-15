import 'package:flutter/material.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';

class DocumentoDeIdentificacao extends StatefulWidget {
   DocumentoDeIdentificacao(
      {Key? key, required this.documento,
        required this.color})
      : super(key: key);

  final Arquivo documento;
  Color color;

  @override
  State<DocumentoDeIdentificacao> createState() =>
      _DocumentoDeIdentificacaoState();
}

class _DocumentoDeIdentificacaoState extends State<DocumentoDeIdentificacao> {
  @override
  void initState() {
    super.initState();
    widget.documento.file;
  }

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
            widget.documento.descricao.toString(),
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
      onTap: () async {
        await widget.documento.getImageGallery();
        setState(() {
          widget.color = widget.documento.file != null ? Colors.green : Colors.red;
        });
      },
      child: Icon(Icons.file_upload, size: 30, color: widget.color));

  Widget _buscarImagemDaCameraoSmartphone() => GestureDetector(
        onTap: () async {
          await widget.documento.getImageCamera();
          setState(() {
            widget.color = widget.documento.file != null ? Colors.green : Colors.red;
          });
        },
        child: Icon(Icons.add_a_photo, size: 30, color: widget.color),
      );
}
