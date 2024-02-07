import 'package:flutter/material.dart';
import 'package:flutter1_firebase/pages/create_page.dart';
import 'package:flutter1_firebase/servise/auth_servise.dart';
import 'package:flutter1_firebase/servise/rtdb_service.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];
  bool isLoading = false;

  Future _callNextCreatePage() async {
    Map result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CreatePage();
    }));

    if (result != null && result.containsKey("data")) {
      print(result['data']);
      _apiPostList();
    }
  }

  _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var list = await RTDBService.getPosts();
    items.clear();
    setState(() {
      items = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Database"),
        actions: [
          IconButton(
              onPressed: () {
                AuthService.SignOut(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemOfPost(items[index]);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _callNextCreatePage();
        },
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Container(
            height: 66,
            width: 66,
            child: post.img_url!=null
              ?Image.network(post.img_url!,fit: BoxFit.cover,)
                :Image.asset("assets/ic_default.jpg",fit: BoxFit.cover,)
          ),
          title: Text(
            post.first_name!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          subtitle: Text(post.content!),
        )
      ],
    );
  }
}
