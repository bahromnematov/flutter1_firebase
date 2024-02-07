import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../model/post_model.dart';

class RTDBService {
  static final _databse = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(Post post) async {
    _databse.child("post").push().set(post.toJon());
    return _databse.onChildAdded;
  }

  static Future<List<Post>> getPosts() async {
    List<Post> items = [];

    Query _query = _databse.ref.child("post");
    DatabaseEvent event = await _query.once();

    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
          first_name: map['first_name'],
          content: map['content'],
          img_url: map['img_url']);
      items.add(post);
    }
    return items;
  }
}
