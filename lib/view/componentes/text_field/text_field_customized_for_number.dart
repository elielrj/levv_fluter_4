import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/mascara/mask.dart';

Widget TextFieldCustomizedForNumber(TextEditingController controller,
    String labelText,
    {int maxLength = 10}) =>
    TextField(
      onTap: () {},

      ///1.1
      controller: controller,

      ///2
      keyboardType: TextInputType.number,

      ///1.2
      decoration: InputDecoration(
        counterText: controller.text.length <= 1
            ? "${controller.text.length} caracter"
            : "${controller.text.length} caracteres",

        ///3
        labelText: labelText,
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
        suffixIcon: controller.text.isEmpty
            ? Container(
          width: 0,
        )
            : IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => controller.clear(),
        ),
        fillColor: Colors.white,
        filled: true,
      ),

      ///4
      maxLength: maxLength,

      style: const TextStyle(fontSize: 18),
    );
