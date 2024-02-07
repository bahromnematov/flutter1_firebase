import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance.ref();

  static final folder = "post_image";

  static Future<String> uploadImage(File _image) async {
    String img_name = "image_" + DateTime.now().toString();

    var firebaseStorage = _storage.child(folder).child(img_name);

    var uploadTask = firebaseStorage.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String download_url = await firebaseStorage.getDownloadURL();
    print(download_url);
    return download_url;
  }
}
