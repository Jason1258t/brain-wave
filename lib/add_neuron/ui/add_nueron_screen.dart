import 'dart:io';

import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/colors.dart';

class AddNeuron extends StatefulWidget {
  const AddNeuron({Key? key}) : super(key: key);

  @override
  State<AddNeuron> createState() => _AddNeuronState();
}

class _AddNeuronState extends State<AddNeuron> {
  final TextEditingController _gitController = TextEditingController();
  final TextEditingController _tegController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  var _image;
  var imagePicker;
  var type;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _displayTextInputDialog(BuildContext context,
        TextEditingController controller, String title) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors.widgetsBackground,
              title: Text(
                title,
                style: AppTypography.font16lightGray,
              ),
              content: TextField(
                style: AppTypography.font14milk,
                onChanged: (value) {},
                controller: controller,
              ),
              actions: <Widget>[
                MaterialButton(
                  color: AppColors.purpleButton,
                  textColor: AppColors.lightBlueText,
                  child: const Text('Сохранить'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      setState(() {});
                    });
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.purpleButton,
          title: const Text(
            'Доабвление нейронной сети',
            style: AppTypography.font20fff,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 60,
            decoration: const BoxDecoration(
              color: AppColors.background,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipRRect(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(60), // Image radius
                        child: _image != null
                            ? Image.file(
                                _image,
                              )
                            : const Image(
                                image: AssetImage(
                                  'Assets/small_empty_img.png',
                                ),
                              ),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          var source = ImageSource.gallery;
                          XFile image = await imagePicker.pickImage(
                              source: source,
                              imageQuality: 50,
                              preferredCameraDevice: CameraDevice.front);

                          _image = File(image.path);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.edit_note,
                          color: AppColors.lightBlueText,
                          size: 30,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                const Text(
                  'Название',
                  style: AppTypography.font32white,
                ),
                const SizedBox(
                  height: 19,
                ),
                InkWell(
                  onTap: () {
                    _displayTextInputDialog(context, _gitController,
                        'Ссылка на Git с документацией');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: AppColors.addNeuronBackgroundWidget,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        _gitController.text != ''
                            ? _gitController.text
                            : 'Ссылка на Git с документацией',
                        style: AppTypography.font18lightBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    _displayTextInputDialog(
                        context, _tegController, 'Добавте тег');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: AppColors.addNeuronBackgroundWidget,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Text(
                        "Тег: ${_tegController.text}",
                        style: AppTypography.font18lightBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.addNeuronBackgroundWidget,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    maxLines: null,
                    style: AppTypography.font18lightBlue,
                    decoration: const InputDecoration(
                        filled: true, border: InputBorder.none),
                    controller: _descriptionController,
                  ),
                ),
                const SizedBox(height: 34,),
                CustomElevatedButton(
                  callback: () {  }, //TODo добавление в fireBAse
                  text: 'Отправить на проверку',
                ),
              ],
            ),
          ),
        ));
  }
}
