import 'package:flutter/material.dart';
/*
Widget textFieldCostumizadoParaNome(TextEditingController controller,
        String labelText, TextInputType keyboardType, maxLength) =>
    TextField(
      onTap: () {},
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        counterText: controller.text.length <= 1
            ? "${controller.text.length} caracter"
            : "${controller.text.length} caracteres",
        labelText: labelText,
        labelStyle:
            const TextStyle(backgroundColor: Colors.white, color: Colors.black),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black12, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 2)),
        prefixIcon: Icon(
          Icons.account_circle,
          color: (controller.text.length < 3 ? Colors.black : Colors.green),
        ),
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
      maxLength: maxLength,
      style: const TextStyle(fontSize: 18),
    );
*/