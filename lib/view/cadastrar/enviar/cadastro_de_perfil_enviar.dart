import 'package:flutter/material.dart';

class CadastroDePerfilEnviar extends StatefulWidget {
  const CadastroDePerfilEnviar(
      {Key? key, required this.controller, required this.labelText, required this.keyboardType})
      : super(key: key);

  final controller;
  final labelText;
  final keyboardType;

  @override
  State<CadastroDePerfilEnviar> createState() =>
      _CadastroDePerfilEnviarState();
}

class _CadastroDePerfilEnviarState extends State<CadastroDePerfilEnviar> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {},
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        counterText: widget.controller.text.length <= 1
            ? "${widget.controller.text.length} caracter"
            : "${widget.controller.text.length} caracteres",
        labelText: widget.labelText,
        labelStyle:
            const TextStyle(backgroundColor: Colors.white, color: Colors.black),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black12, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 2)),
        prefixIcon: const Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        suffixIcon: widget.controller.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () => widget.controller.clear(),
              ),
        fillColor: Colors.white,
        filled: true,
      ),
      maxLength: 100,
      style: const TextStyle(fontSize: 18),
    );
  }


}
