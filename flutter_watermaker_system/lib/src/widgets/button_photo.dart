import 'package:flutter/material.dart';

class ButtonPhoto extends StatefulWidget {
  void Function()? takePhoto;
  void Function()? pickPhoto;

  ButtonPhoto({Key? key, required this.pickPhoto, required this.takePhoto})
      : super(key: key);

  @override
  _ButtonPhotoState createState() => _ButtonPhotoState();
}

class _ButtonPhotoState extends State<ButtonPhoto> {
  bool _showAdditionalButtons = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: !_showAdditionalButtons,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _showAdditionalButtons = !_showAdditionalButtons;
              });
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.add_a_photo,
                ),
                Text(
                  'Adicionar',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: _showAdditionalButtons,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        widget.takePhoto!();
                        setState(() {
                          _showAdditionalButtons = !_showAdditionalButtons;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Icon(Icons.camera_alt),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Tirar foto'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        widget.pickPhoto!();
                        setState(() {
                          _showAdditionalButtons = !_showAdditionalButtons;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Icon(Icons.photo),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Selecionar da galeria',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
