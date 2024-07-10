import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_gemini/flutter_gemini.dart';

Future<Uint8List> loadAsset(String path) async {
  ByteData data = await rootBundle.load(path);
  Uint8List bytes = data.buffer.asUint8List();
  return bytes;
}

Future<void> textGen() async {
  print("Trying");
  final gemini = Gemini.instance;

  Uint8List selectedImage = await loadAsset('assets/images/logo.png');
  gemini
      .textAndImage(text: "What is this picture?", images: [selectedImage])
      .then((value) => print(value?.content?.parts?.last.text ?? ''))
      .catchError((e) => print(e));
}

Future<void> textGen2() async {
  print("Trying");
  final gemini = Gemini.instance;
  gemini
      .chat([
        Content(parts: [
          Parts(text: 'Write the first line of a story about a magic backpack.')
        ], role: 'user'),
        Content(parts: [
          Parts(
              text:
                  'In the bustling city of Meadow brook, lived a young girl named Sophie. She was a bright and curious soul with an imaginative mind.')
        ], role: 'model'),
        Content(parts: [
          Parts(text: 'Can you set it in a quiet village in 1600s France?')
        ], role: 'user'),
      ])
      .then((value) => print(value?.output ?? 'without output'))
      .catchError((e) => print(e));
}
