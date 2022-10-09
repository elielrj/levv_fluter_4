import 'package:flutter/material.dart';

import '../../../api/codigo_do_pais/api_codigo_telefone_pais.dart';
import '../../../api/mascara/mask.dart';
import '../../../api/texto/text_levv.dart';
import '../../componentes/counter_text/counter_text.dart';

class PhoneNumberLevv extends StatefulWidget {
  const PhoneNumberLevv(
      {Key? key,
      required this.maskPhoneNumber,
      required this.apiCoutryPhoneCode})
      : super(key: key);

  final Mask maskPhoneNumber;
  final ApiCodigoTelefoneDoPais apiCoutryPhoneCode;

  @override
  State<PhoneNumberLevv> createState() => _PhoneNumberLevvState();
}

class _PhoneNumberLevvState extends State<PhoneNumberLevv> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: widget.apiCoutryPhoneCode.codigoDoTelefoneDoPais),
        const SizedBox(width: 8),
        SizedBox(
          width: 280,
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              TextField(
                controller: widget.maskPhoneNumber.textEditingController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    counterText:
                        CounterText(mask: widget.maskPhoneNumber).contar(),
                    labelText: TextLevv.CELULAR,
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black12, width: 2)),
                    prefixIcon: const Icon(
                      Icons.phone_iphone,
                      color: Colors.black,
                    ),
                    suffixIcon: widget
                            .maskPhoneNumber.textEditingController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                widget.maskPhoneNumber.textEditingController
                                    .clear();
                              });
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                          ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: widget.maskPhoneNumber.formatter.getHint()),
                inputFormatters: [
                  widget.maskPhoneNumber.formatter.getFormatter()
                ],
                maxLength: 20,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
