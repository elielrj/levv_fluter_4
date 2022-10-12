import 'package:flutter/material.dart';

import 'package:country_phone_code_picker/country_phone_code_picker.dart';
import 'package:levv4/api/cor/colors_levv.dart';

///https://pub.dev/packages/country_phone_code_picker

class CodigoDoPais {
  final CountryPhoneCodePicker _codigoDoPais =
      CountryPhoneCodePicker.withDefaultSelectedCountry(
    height: 60,
    searchSheetBackground: ColorsLevv.FUNDO_400,
    backgroundColor: Colors.transparent,
    defaultCountryCode:
        Country(name: 'Brasil', countryCode: 'BR', phoneCode: '+55'),
    borderRadius: 8,
    borderWidth: 1.4,
    borderColor: Colors.white,
    style: const TextStyle(fontSize: 16, backgroundColor: Colors.transparent),
    searchBarHintText: 'Busque o pelo nome do seu País',
  );

  CountryPhoneCodePicker get codigoDoPais => _codigoDoPais;
}
