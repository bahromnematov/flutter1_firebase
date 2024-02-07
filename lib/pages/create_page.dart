import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter1_firebase/model/post_model.dart';
import 'package:flutter1_firebase/servise/rtdb_service.dart';
import 'package:flutter1_firebase/servise/sorage_servise.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  static final String id = "create_page";

  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isLoading = false;
  var nameController = TextEditingController();
  var contentController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  _createPost() {
    String firstName = nameController.text.toString().trim();
    String content = contentController.text.toString().trim();

    if (firstName.isEmpty || content.isEmpty) return;

    _apiUploadImage(firstName,content);
  }

  _apiUploadImage(String firstName,String content){
    setState(() {
      isLoading=true;
    });
    StorageService.uploadImage(_image!)
    .then((_img_url) => {_apiCretePost(firstName, content,_img_url)});
  }

  _apiCretePost(String firstName, String content,String img_url) {
    setState(() {
      isLoading = true;
    });
    var post = Post(first_name: firstName, content: content,img_url: img_url);
    RTDBService.addPost(post).then((value) => {
          _resAddPost(),
        });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _getImage();
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/ic_camera.jpg",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(hintText: "Content"),
                ),
                SizedBox(
                  height: 12,
                ),
                MaterialButton(
                  height: 50,
                  color: Colors.blue,
                  onPressed: () {
                    _createPost();
                  },
                  child: Text("Create"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
