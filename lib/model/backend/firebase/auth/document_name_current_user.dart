import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin DocumentNameCurrentUser{
  String name( User currentUser)  {
    var celular =  currentUser.phoneNumber;
    var email =  currentUser.email;

    String documentName = "";

    if(celular != null && celular != ""){
      documentName = celular.toString();
    }
    if(email != null && email != ""){
      documentName = email.toString();
    }

    return documentName;
  }

}