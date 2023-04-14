import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'imagen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generar imagen perrito',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Generar imagen perrito'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, watch, _) {
                final imageUrl = watch.watch(imageProvider).imageUrl;
                
                return imageUrl != null
                    ? Image.network(
                        imageUrl,
                        height: 40,
                        width: 40,
                      )
                    : Container();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                getImageUrl(context as ProviderReference);
              },
              child: Text('Generate Dog Image'),
            ),
          ],
        ),
      ),
    );
  }
}
