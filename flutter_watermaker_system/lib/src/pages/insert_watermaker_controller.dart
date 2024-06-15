import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/src/entities/data_watermaker_entity.dart';
import 'package:flutter_watermaker_system/src/util/insert_watermaker.dart';

class InsertWaterMakerController extends ChangeNotifier {
  final ValueNotifier<List<File>> _listImages = ValueNotifier<List<File>>([]);
  final ValueNotifier<List<File>> lisImagesWithOutWatermaker =
      ValueNotifier<List<File>>([]);

  final ValueNotifier<DataWatermakerEntity>? dataWatermakerEntity =
      ValueNotifier<DataWatermakerEntity>(DataWatermakerEntity());
  List<File> get images => _listImages.value;

  Listenable get listenables => Listenable.merge([
        _listImages,
        lisImagesWithOutWatermaker,
        dataWatermakerEntity,
        this,
      ]);

  void addImageWithWatermaker(File image) {
    _listImages.value.add(image);
    notifyListeners();
  }

  void removeImageWithWatermaker(File image) {
    lisImagesWithOutWatermaker.value.remove(image);
    lisImagesWithOutWatermaker.notifyListeners();
    _listImages.value.remove(image);
    notifyListeners();
  }

  Future<void> insertWatermaker(
    Future<File?> Function()? takePhotoOrPickPhoto,
  ) async {
    File? imagemOriginal = await takePhotoOrPickPhoto!();
    if (imagemOriginal != null) {
      final texts = [
        dataWatermakerEntity!.value.titulo!,
        dataWatermakerEntity!.value.subtitulo!,
        dataWatermakerEntity!.value.dataCriacao!,
        dataWatermakerEntity!.value.descricao!,
        dataWatermakerEntity!.value.logradouro!,
        dataWatermakerEntity!.value.precisao!,
        dataWatermakerEntity!.value.latitude!,
        dataWatermakerEntity!.value.longitude!,
        dataWatermakerEntity!.value.autorDaFoto!,
        dataWatermakerEntity!.value.observacao!,
      ];
      File imagemComMarcaDagua = await addWatermarkToImage(
          imageFile: imagemOriginal,
          texts: texts,
          saveBackupImage: lisImagesWithOutWatermaker.value);
      addImageWithWatermaker(imagemComMarcaDagua);
    }
  }

  DataWatermakerEntity popularDataWatermark(
    String? titulo,
    String? subtitulo,
    String? dataCriacao,
    String? descricao,
    String? logradouro,
    String? precisao,
    String? latitude,
    String? longitude,
    String? autorDaFoto,
    String? observacao,
  ) {
    dataWatermakerEntity?.value.titulo = titulo;
    dataWatermakerEntity?.value.subtitulo = subtitulo;
    dataWatermakerEntity?.value.dataCriacao = dataCriacao;
    dataWatermakerEntity?.value.descricao = descricao;
    dataWatermakerEntity?.value.logradouro = logradouro;
    dataWatermakerEntity?.value.precisao = precisao;
    dataWatermakerEntity?.value.latitude = latitude;
    dataWatermakerEntity?.value.longitude = longitude;
    dataWatermakerEntity?.value.autorDaFoto = autorDaFoto;
    dataWatermakerEntity?.value.observacao = observacao;

    return dataWatermakerEntity!.value;
  }

  Future<void> editWatermaker(
    File imagemOriginal,
  ) async {
    final texts = [
      dataWatermakerEntity!.value.titulo!,
      dataWatermakerEntity!.value.subtitulo!,
      dataWatermakerEntity!.value.dataCriacao!,
      dataWatermakerEntity!.value.descricao!,
      dataWatermakerEntity!.value.logradouro!,
      dataWatermakerEntity!.value.precisao!,
      dataWatermakerEntity!.value.latitude!,
      dataWatermakerEntity!.value.longitude!,
      dataWatermakerEntity!.value.autorDaFoto!,
      dataWatermakerEntity!.value.observacao!,
    ];

    removeImageWithWatermaker(imagemOriginal);
    final originalImageName = imagemOriginal.path.split('/').last;
    File imagemComMarcaDagua = await addWatermarkToImage(
        imageFile: lisImagesWithOutWatermaker.value
            .where(
                (element) => element.path.split('/').last == originalImageName)
            .first,
        texts: texts,
        saveBackupImage: lisImagesWithOutWatermaker.value);
    addImageWithWatermaker(imagemComMarcaDagua);
  }

  void isInsertOrEditWaterMaker(
    File? imagemOriginal,
    Future<File?> Function()? takePhotoOrPickPhoto,
  ) {
    if (imagemOriginal == null) {
      insertWatermaker(() => takePhotoOrPickPhoto!());
    } else {
      editWatermaker(imagemOriginal);
    }
  }
}
