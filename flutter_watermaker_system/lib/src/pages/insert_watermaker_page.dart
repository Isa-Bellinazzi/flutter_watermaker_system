import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/flutter_watermaker_system.dart';
import 'package:flutter_watermaker_system/src/widgets/dialog_info_watermaker.dart';

class InsertWatermakerPage extends StatefulWidget {
  Future<File?> Function()? takePhoto;
  Future<File?> Function()? pickPhoto;
  List<File> images;
  String titlePage;
  InsertWatermakerPage(
      {Key? key,
      required this.titlePage,
      required this.images,
      required this.pickPhoto,
      required this.takePhoto})
      : super(key: key);

  @override
  _InsertWatermakerPageState createState() => _InsertWatermakerPageState();
}

class _InsertWatermakerPageState extends State<InsertWatermakerPage> {
  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text(
              widget.titlePage,
              style: theme.fontStyle.titleMedium.cl(Colors.white70),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colors.primaryDark,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                widget.images[index],
                                height: 300,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      showDialogInfoWatermaker(
                                          context, widget.images);
                                    },
                                    child: const Text('Editar')),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.images.removeAt(index);
                                      });
                                    },
                                    child: const Text('Excluir'))
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              ButtonPhoto(
                pickPhoto: () async {
                  return showDialogInfoWatermakerWithFunction(
                      context, widget.pickPhoto!, widget.images);
                },
                takePhoto: () async {
                  return showDialogInfoWatermakerWithFunction(
                      context, widget.takePhoto!, widget.images);
                },
              ),
            ],
          ),
        ));
  }
}
