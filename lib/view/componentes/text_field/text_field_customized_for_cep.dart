import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/mascara/mask.dart';

class TextFieldCustomizedForCep extends StatefulWidget {
  const TextFieldCustomizedForCep({Key? key, required this.controller})
      : super(key: key);

  final Mask controller;

  @override
  State<TextFieldCustomizedForCep> createState() =>
      _TextFieldCustomizedForCepState();
}

class _TextFieldCustomizedForCepState extends State<TextFieldCustomizedForCep> {
  @override
  void initState() {
    super.initState();
    widget.controller.textEditingController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {},

      ///1.1
      controller: widget.controller.textEditingController,

      ///2
      keyboardType: TextInputType.number,

      ///1.2
      decoration: InputDecoration(
        counterText: widget.controller.formatter
                    .getMaskTextInputFormatter()
                    .getUnmaskedText()
                    .length <=
                1
            ? "${widget.controller.formatter.getMaskTextInputFormatter().getUnmaskedText().length} caracter"
            : "${widget.controller.formatter.getMaskTextInputFormatter().getUnmaskedText().length} caracteres",

        ///3
        labelText: "CEP",
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

        ///1.3
        suffixIcon: widget.controller.textEditingController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  widget.controller.textEditingController.clear();
                  widget.controller.formatter
                      .getMaskTextInputFormatter()
                      .clear();
                },
              ),
        fillColor: Colors.white,
        filled: true,
      ),

      ///1.3
      inputFormatters: [
        widget.controller.formatter.getMaskTextInputFormatter()
      ],

      ///4
      maxLength: 9,
      style: const TextStyle(fontSize: 18),
    );
  }
}
