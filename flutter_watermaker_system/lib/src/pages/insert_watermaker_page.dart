import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_watermaker_system/flutter_watermaker_system.dart';
import 'package:flutter_watermaker_system/src/pages/insert_watermaker_controller.dart';
import 'package:flutter_watermaker_system/src/widgets/dialog_info_watermaker.dart';

class InsertWatermakerPage extends StatefulWidget {
  final Future<File?> Function()? takePhoto;
  final Future<File?> Function()? pickPhoto;
  final String titlePage;
  const InsertWatermakerPage({
    Key? key,
    required this.titlePage,
    required this.pickPhoto,
    required this.takePhoto,
  }) : super(key: key);

  @override
  _InsertWatermakerPageState createState() => _InsertWatermakerPageState();
}

class _InsertWatermakerPageState extends State<InsertWatermakerPage> {
  late InsertWaterMakerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = InsertWaterMakerController();
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();
    return AnimatedBuilder(
      animation: _controller.listenables,
      builder: (context, child) => Scaffold(
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
                      itemCount: _controller.images.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                _controller.images[index],
                                height: 300,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showDialogInfoWatermaker(
                                      context,
                                      _controller,
                                      _controller.images[index],
                                    );
                                  },
                                  child: const Text('Editar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _controller.removeImageWithWatermaker(
                                          _controller.images[index]);
                                    });
                                  },
                                  child: const Text('Excluir'),
                                ),
                              ],
                            ),
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
                      context, widget.pickPhoto!, _controller);
                },
                takePhoto: () async {
                  return showDialogInfoWatermakerWithFunction(
                      context, widget.takePhoto!, _controller);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _controller.lisImagesWithOutWatermaker.value.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          _controller.lisImagesWithOutWatermaker.value[index],
                          height: 300,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialogInfoWatermaker(
                                context,
                                _controller,
                                _controller.images[index],
                              );
                            },
                            child: const Text('Editar'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _controller.removeImageWithWatermaker(
                                    _controller.images[index]);
                              });
                            },
                            child: const Text('Excluir'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
