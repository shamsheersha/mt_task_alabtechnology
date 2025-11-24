import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mt_task_alabtechnology/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostProvider extends ChangeNotifier {
  List<PostModel> posts = [];
  bool isLoading = false;
  String? errorMessage;
  bool isOfflineMode = false;

  Future<void> fetchPosts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      loadCachedPosts();
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
    "Content-Type": "application/json",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
  },);
      log('${response.body}........');
      if (response.statusCode == 200) {
        log(response.body);
        List<dynamic> body = jsonDecode(response.body);
        posts = body.map((dynamic item) => PostModel.fromJson(item)).toList();
        isOfflineMode = false;

        var box = await Hive.openBox<PostModel>('postBox');
        await box.clear();
        await box.addAll(posts);
      } else {
        errorMessage = "Failed to load posts. Status: ${response.statusCode}";
        loadCachedPosts();
      }
    } catch (e) {
      errorMessage = "Error: $e";
      loadCachedPosts();
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCachedPosts() async {
    var box = await Hive.openBox<PostModel>('postBox');
    if (box.isNotEmpty) {
      posts = box.values.toList();
      isOfflineMode = true;
      errorMessage = 'No Internet.';
    } else {
      errorMessage = 'No Internet and no data';
    }
    isLoading = false;
    notifyListeners();
  }
}
