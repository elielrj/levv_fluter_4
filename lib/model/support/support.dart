
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';

class Validador{

  bool isValidCpf(String cpf){
    return CPFValidator.isValid(cpf);
  }

  bool isValidCnpj(String cnpj){
    return CNPJValidator.isValid(cnpj);
  }

}