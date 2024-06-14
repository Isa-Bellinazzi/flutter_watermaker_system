import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/src/util/insert_watermaker.dart';

class DialogInfoWatermaker extends StatefulWidget {
  List<File> listaDeImagens;
  Future<File?> Function()? takePhotoOrPickPhoto;
  DialogInfoWatermaker(
      {Key? key, this.takePhotoOrPickPhoto, required this.listaDeImagens})
      : super(key: key);

  @override
  _DialogInfoWatermakerState createState() => _DialogInfoWatermakerState();
}

class _DialogInfoWatermakerState extends State<DialogInfoWatermaker> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textoTitulo = TextEditingController();
  TextEditingController textoSubtitulo = TextEditingController();
  TextEditingController textoDescricao = TextEditingController();
  TextEditingController textoDataCriacao = TextEditingController();
  TextEditingController textoLogradouro = TextEditingController();
  TextEditingController textoPrecisao = TextEditingController();
  TextEditingController textoLatitude = TextEditingController();
  TextEditingController textoLongitude = TextEditingController();
  TextEditingController textoAutorDaFoto = TextEditingController();
  TextEditingController textoObservacao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Informações do Watermarker'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: textoTitulo,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoSubtitulo,
                decoration: const InputDecoration(
                  labelText: 'Subtítulo',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoDataCriacao,
                decoration: const InputDecoration(
                  labelText: 'Data de Criação',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoDescricao,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoLogradouro,
                decoration: const InputDecoration(
                  labelText: 'Logradouro',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoPrecisao,
                decoration: const InputDecoration(
                  labelText: 'Precisão',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoLatitude,
                decoration: const InputDecoration(
                  labelText: 'Latitude',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoLatitude,
                decoration: const InputDecoration(
                  labelText: 'Longitude',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoAutorDaFoto,
                decoration: const InputDecoration(
                  labelText: 'Autor da Foto',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
              TextFormField(
                controller: textoObservacao,
                decoration: const InputDecoration(
                  labelText: 'Observação',
                  labelStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Salvar'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              final File? imagemOriginal = await widget.takePhotoOrPickPhoto!();
              if (imagemOriginal != null) {
                final texts = [
                  textoTitulo.text,
                  textoSubtitulo.text,
                  textoDataCriacao.text,
                  textoDescricao.text,
                  textoLogradouro.text,
                  textoPrecisao.text,
                  textoLatitude.text,
                  textoLongitude.text,
                  textoAutorDaFoto.text,
                  textoObservacao.text,
                ];
                final File imagemComMarcaDagua = await addWatermarkToImage(
                  imageFile: imagemOriginal,
                  texts: texts,
                );
                widget.listaDeImagens.add(imagemComMarcaDagua);

                setState(() {
                  widget.listaDeImagens;
                });
              }
            }
          },
        ),
      ],
    );
  }
}

void showDialogInfoWatermakerWithFunction(BuildContext context,
    Future<File?> Function()? takePhotoOrPickPhoto, List<File> images) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DialogInfoWatermaker(
        listaDeImagens: images,
        takePhotoOrPickPhoto: () {
          return takePhotoOrPickPhoto!();
        },
      );
    },
  );
}

void showDialogInfoWatermaker(BuildContext context, List<File> images) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DialogInfoWatermaker(
        listaDeImagens: images,
      );
    },
  );
}
