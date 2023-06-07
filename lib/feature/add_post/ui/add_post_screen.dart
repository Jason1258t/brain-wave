import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/add_image_from_phone/image_from_phone.dart';
import 'package:brain_wave_2/widgets/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/avatars/small_avatar.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _namePostController = TextEditingController(text: 'Название поста');
  final _descriptionPostController = TextEditingController(text: 'Чего нового');

  Future<void> _displayTextInputDialog(
      BuildContext context,
      TextEditingController controller,
      String titleAlertDialog,
      String editType) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.widgetsBackground,
            title: Text(
              'Изменить $titleAlertDialog',
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

  @override
  Widget build(BuildContext context) {
    AppRepository _appRepository =
        RepositoryProvider.of<AppRepository>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        flexibleSpace: SafeArea(
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  text: 'Опубликовать',
                  callback: () async{
                    Navigator.pushNamed(context, '/add_image');

                  }, //TODo доделать добавление поста
                  width: 150,
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallAvatar(
                    avatar: _appRepository.getCurrentUser()?.photoURL ?? '',
                    name: _appRepository.getCurrentUser()?.displayName ?? ''),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _namePostController.text,
                            style: AppTypography.font20white,
                          ),
                          InkWell(
                            onTap: () {
                              _displayTextInputDialog(
                                  context,
                                  _namePostController,
                                  'название поездки',
                                  'name');
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.pending_actions,
                                color: AppColors.lightBlueText,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        _appRepository.getCurrentUser()?.displayName ?? 'name',
                        style: AppTypography.font14milk,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: AppColors.widgetsBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: TextField(
                keyboardType: TextInputType.multiline,
                expands: true,
                maxLines: null,
                style: AppTypography.font16lightGray,
                decoration: const InputDecoration(filled: true, border: InputBorder.none),
                controller: _descriptionPostController,
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: AppColors.widgetsBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ]),
        ),
      ),
    );
  }
}
