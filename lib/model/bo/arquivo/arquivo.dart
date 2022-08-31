import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Arquivo {

  String? descricao;
  XFile? image;

  Arquivo({
    this.descricao,
    this.image
  });

  Future<XFile?> getImageCamera() async {
    final ImagePicker _picker = ImagePicker();

    image = await _picker.pickImage(source: ImageSource.camera);
  }

  Future<XFile?> getImageGallery() async {
    final ImagePicker _picker = ImagePicker();

    image = await _picker.pickImage(source: ImageSource.gallery);
  }

}