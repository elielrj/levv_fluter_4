
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';

class ValidadorCnpjCpf{

  static bool isValidCpf(String cpf){
    return CPFValidator.isValid(cpf);
  }

  static bool isValidCnpj(String cnpj){
    return CNPJValidator.isValid(cnpj);
  }

}