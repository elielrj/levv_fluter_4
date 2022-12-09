import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Arquivo {

  String? descricao;
  XFile? file;

  Arquivo({
    this.descricao,
    this.file
  });

  Future<XFile?> getImageCamera() async {
    final ImagePicker _picker = ImagePicker();

    file = await _picker.pickImage(source: ImageSource.camera);
  }

  Future<XFile?> getImageGallery() async {
    final ImagePicker _picker = ImagePicker();

    file = await _picker.pickImage(source: ImageSource.gallery);
  }



}