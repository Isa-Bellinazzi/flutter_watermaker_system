import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/flutter_watermaker_system.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  List<File> images = [];

  Future<File?> _takePhoto() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        return _image;
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Falha ao tirar foto: $e');
    }
    return null;
  }

  Future<File?> _pickPhoto() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        return _image;
      } else {
        if (kDebugMode) {
          print('Imagem não selecionada');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Falha ao selecionar foto da galeria: $e');
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InsertWatermakerPage(
      titlePage: 'Inserir Marca da Água',
      pickPhoto: _pickPhoto,
      takePhoto: _takePhoto,
    );
  }
}
