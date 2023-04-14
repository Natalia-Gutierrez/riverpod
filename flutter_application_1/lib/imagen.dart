import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ImageProvider extends ChangeNotifier {
  String _imageUrl='';

  String get imageUrl => _imageUrl;

  void setImageUrl(String url) {
    _imageUrl = url;
    notifyListeners();
  }
  
}
final imageProvider = StateProvider((ref) => ImageProvider());

void getImageUrl(ProviderReference ref) async {
  final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final imageUrl = data['message'];
    ref.read(imageProvider).setImageUrl(imageUrl);
  } else {
    print('Failed to load image');
  }
}

