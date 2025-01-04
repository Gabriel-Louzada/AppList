import 'dart:io';
import 'package:image_picker/image_picker.dart';

class VincularImagem {
  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    //Nessa variavel o sistema irá armazenar o caminho da imagem selecionada
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      return imageFile;
    } else {
      return null;
    }
  }
}
