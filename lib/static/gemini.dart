import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hero_chum/models/gemini_response.dart';

GeminiResponseModel defaultResponse = GeminiResponseModel(
  summary: "error",
  title: "error",
  complexity: 0,
  emoji: "",
);

Future<Uint8List> loadAsset(String path) async {
  ByteData data = await rootBundle.load(path);
  Uint8List bytes = data.buffer.asUint8List();
  return bytes;
}

Future<void> listModels() async {
  final gemini = Gemini.instance;
  gemini.listModels().then((value) => print(value));
}

Future<GeminiResponseModel> geminiCall(
    PlatformFile file, String description) async {
  final gemini = Gemini.instance;

  // transform PlatformFile to Uint8List from the web, path is not available
  Uint8List selectedImage = file.bytes!;

  try {
    final response = await gemini.textAndImage(
      text: "Answer only with a JSON object, nothing else. "
          "Description: $description\n"
          "Given the following image and description, generate a task:\n"
          "{\n"
          "\"complexity\": <integer between 1-5 meaning how long does it take for one person to complete the task>,\n"
          "\"summary\": <string, fix description grammar issues, rephrase. Do not shorten>,\n"
          "\"title\": <string, short title for the task>,\n"
          "\"emoji\": <a string containing a single emoji that best describes the task>\n"
          "}\n\n"
          "If the image does not match the description or is not relevant/appropriate, return {} instead.",
      images: [selectedImage],
      modelName: "models/gemini-1.5-flash",
    );

    final String responseText = response?.content?.parts?.last.text ?? '';

    if (responseText.isEmpty || responseText == "{}") {
      print("Error: $responseText");
      return defaultResponse;
    }

    final jsonObj = GeminiResponseModel.fromJson(json.decode(responseText));
    print(jsonObj.toJson());

    return jsonObj;
  } catch (e) {
    print("ERROR");
    print(e);
    return defaultResponse;
  }
}
