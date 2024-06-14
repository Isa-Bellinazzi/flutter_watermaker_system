import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Future<File> addWatermarkToImage({
  required File imageFile,
  required List<String> texts,
}) async {
  final Uint8List imageBytes = await imageFile.readAsBytes();
  final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final ui.Image image = frameInfo.image;

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint();
  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  // Draw the original image onto the canvas
  canvas.drawImage(image, Offset.zero, paint);

  // Add text as watermark
  double textHeight = 0;
  const double fontSize = 48; // Increased font size
  for (String text in texts) {
    textPainter.text = TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.white, // White text color
        fontSize: fontSize,
        shadows: [
          Shadow(
            blurRadius: 2.0,
            color: Colors.black,
            offset: Offset(1.0, 1.0),
          ),
        ],
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(20, textHeight));
    textHeight += textPainter.height + 10;
  }

  final picture = recorder.endRecording();
  final img = await picture.toImage(image.width, image.height);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  // Save the watermarked image to a temporary file
  final tempDir = Directory.systemTemp;
  final tempFile = File('${tempDir.path}/watermarked_image.png');
  await tempFile.writeAsBytes(buffer);

  return tempFile;
}
