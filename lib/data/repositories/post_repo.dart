import 'package:dio/dio.dart';
import 'package:dios/data/models/post_model.dart';
import 'package:dios/data/repositories/api/api.dart';
import 'package:flutter/material.dart';

class PostRepo {
  Api api = Api();

  Future<List<PostModel>> fetchPost(BuildContext context) async {
    try {
      Response response = await api.sendRequest.get("/posts");

      List<dynamic> postMap = response.data;
      return postMap.map((postmap) => PostModel.fromJson(postmap)).toList();
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        snackBars("Bad Response", context);
      }
      if (e.type == DioErrorType.connectionTimeout) {
        snackBars("check your connection", context);
      }

      if (e.type == DioErrorType.receiveTimeout) {
        snackBars("unable to connect to the server", context);
      }

      if (e.type == DioErrorType.unknown) {
        snackBars("Something went wrong", context);
      }

      rethrow;
    }
  }
}

snackBars(String? error, BuildContext context) {
  SnackBar snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      error!,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
