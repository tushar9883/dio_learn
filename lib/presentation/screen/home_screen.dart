import 'package:dios/data/models/post_model.dart';
import 'package:dios/data/repositories/post_repo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostRepo postRepo = PostRepo();
  List<PostModel> postModel = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    postModel = await postRepo.fetchPost(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildPostListView(postModel),
      ),
    );
  }

  Widget buildPostListView(List<PostModel> postData) {
    return ListView.builder(
      itemCount: postData.length,
      itemBuilder: (context, index) {
        PostModel post = postData[index];
        return ListTile(
          title: Text(
            post.title.toString(),
          ),
        );
      },
    );
  }
}
