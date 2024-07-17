import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<File?> pickImageFromGallery({File? image}) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    }
    return null;
  }

  static Future<File?> pickImageFromCamera({File? image}) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    }
    return null;
  }
}
