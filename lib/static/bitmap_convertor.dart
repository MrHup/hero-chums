import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createBitmapDescriptorFromText(String text) async {
  print(text);
  const textStyle = TextStyle(
    fontSize: 60,
    decoration: TextDecoration.none,
    // color: Colors.white,
    fontFamily: 'Emoji',
  );
  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    text: TextSpan(text: text, style: textStyle),
  );

  textPainter.layout();
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);

  textPainter.paint(canvas, Offset.zero);
  final picture = pictureRecorder.endRecording();
  final img = await picture.toImage(
    textPainter.width.toInt(),
    textPainter.height.toInt(),
  );
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  final uint8List = byteData!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(uint8List);
}
