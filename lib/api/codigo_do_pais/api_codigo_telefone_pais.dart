import 'package:flutter/material.dart';

import 'package:country_phone_code_picker/country_phone_code_picker.dart';

///https://pub.dev/packages/country_phone_code_picker

class ApiCodigoTelefoneDoPais {
  final CountryPhoneCodePicker _codigoDoTelefoneDoPais =
      CountryPhoneCodePicker.withDefaultSelectedCountry(
    backgroundColor: Colors.transparent,
    defaultCountryCode:
        Country(name: 'Brasil', countryCode: 'BR', phoneCode: '+55'),
    borderRadius: 5,
    borderWidth: 1,
    borderColor: Colors.transparent,
    style: const TextStyle(fontSize: 16, backgroundColor: Colors.transparent),
    searchBarHintText: 'Search by name',
  );

  CountryPhoneCodePicker get codigoDoTelefoneDoPais => _codigoDoTelefoneDoPais;
}
