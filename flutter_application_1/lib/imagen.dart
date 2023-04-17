import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imgRandom = FutureProvider.autoDispose<String>((ref) async {
  final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json['message'];
  } else {
    throw Exception('Error al cargar imagen');
  }
});

class Imagen extends StatefulWidget {
  const Imagen({super.key});

  @override
  State<Imagen> createState() => _ImagenState();
}

class _ImagenState extends State<Imagen> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Imagen Perrito Random',
                  style: TextStyle(color: Colors.black) , 
                  
                ),
              ]
            ),
            backgroundColor: Color.fromARGB(255, 5, 216, 146)         
            ),
          body: Center(
            child: Consumer(
              builder: (context, watch, _) {
                final imageAsyncValue = watch(imgRandom);
                return imageAsyncValue.when(
                  data: (imageUrl) => Image.network(imageUrl),
                  loading: () => CircularProgressIndicator(),
                  error: (error, stackTrace) => Text('Error al cargar imagen'),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.refresh(imgRandom);
            },
            tooltip: 'Refresh',
            child: Icon(Icons.refresh),
            backgroundColor: Color.fromARGB(255, 5, 216, 146)
          ),
        ),
      ),
    );
  }
}

