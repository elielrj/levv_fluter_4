import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/mascara/mask.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';

Widget TextFieldCustomizedForCpf(
        Mask controller) =>
    TextField(
      onTap: () {},

      ///1.1
      controller: controller.textEditingController,

      ///2
      keyboardType: TextInputType.number,

      ///1.2
      decoration: InputDecoration(
        counterText: controller.formatter
                    .getMaskTextInputFormatter()
                    .getUnmaskedText()
                    .length <=
                1
            ? "${controller.formatter.getMaskTextInputFormatter().getUnmaskedText().length} ${TextLevv.CARACTER}"
            : "${controller.formatter.getMaskTextInputFormatter().getUnmaskedText().length} ${TextLevv.CARACTERES}",

        ///3
        labelText: TextLevv.CPF,
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
        suffixIcon: controller.textEditingController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  controller.textEditingController.clear();
                  controller.formatter.getMaskTextInputFormatter().clear();
                },
              ),
        fillColor: Colors.white,
        filled: true,
      ),

      ///1.3
      inputFormatters: [controller.formatter.getMaskTextInputFormatter()],

      ///4
      maxLength: 14,
      style: const TextStyle(fontSize: 18),
    );
