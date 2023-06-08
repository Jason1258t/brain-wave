import 'dart:io';

import 'package:brain_wave_2/feature/add_post/bloc/add_post_bloc.dart';
import 'package:brain_wave_2/feature/home/bloc/navigation_bloc.dart';
import 'package:brain_wave_2/feature/profie/bloc/profile_bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/buttons/elevated_button.dart';
import 'package:brain_wave_2/widgets/snack_bar/custom_cnack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import '../../../widgets/avatars/small_avatar.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _namePostController = TextEditingController();
  final _descriptionPostController = TextEditingController();

  var _image;
  var imagePicker;
  var type;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

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
              decoration: const InputDecoration(
                  hintText: 'Название', hintStyle: AppTypography.font14milk),
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
    final bloc = BlocProvider.of<AddPostBloc>(context);
    return BlocConsumer<AddPostBloc, AddPostState>(
      listener: (context, state) {
        if (state is AddPostLoadingState) {
          Dialogs.showModal(context, AppAnimations.bouncingSquare);
        }
        if (state is AddPostSuccessState) {
          CustomSnackBar.showSnackBar(context, 'успешно');
          BlocProvider.of<NavigationBloc>(context).add(ViewProfileEvent());
          BlocProvider.of<ProfileBloc>(context)
              .add(ProfilePostsInitialLoadEvent(f: true));
          Navigator.pop(context);
          Dialogs.hide(context);
        }
        if (state is AddPostFailState) {
          CustomSnackBar.showSnackBar(context, 'проблемс');
          Dialogs.hide(context);
        }
      },
      builder: (context, state) {
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
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, right: 8),
                      child: CustomElevatedButton(
                        text: 'Опубликовать',
                        callback: () async {
                          if (_descriptionPostController.text.isNotEmpty && _namePostController.text.isNotEmpty) {
                            bloc.add(AddPostInitialEvent(
                                image: _image,
                                uid: _appRepository.getCurrentUser()!.uid,
                                description: _descriptionPostController.text,
                                title: _namePostController.text));
                          }

                        }, //TODo доделать добавление поста
                        width: 150,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
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
                          avatar:
                              _appRepository.getCurrentUser()?.photoURL ?? '',
                          name: _appRepository.getCurrentUser()?.displayName ??
                              ''),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _displayTextInputDialog(
                                        context,
                                        _namePostController,
                                        'Название поста',
                                        'name');
                                  },
                                  child: Text(
                                    _namePostController.text.isNotEmpty
                                        ? _namePostController.text
                                        : 'Название поста',
                                    style: AppTypography.font20white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              _appRepository.getCurrentUser()?.displayName ??
                                  'name',
                              style: AppTypography.font14milk,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      maxLines: null,
                      style: AppTypography.font18lightBlue,
                      decoration: const InputDecoration(
                        hintText: 'Что нового?',
                          hintStyle: AppTypography.font18lightBlue,
                          filled: true, border: InputBorder.none),
                      controller: _descriptionPostController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        var source = ImageSource.gallery;
                        XFile image = await imagePicker.pickImage(
                            source: source,
                            imageQuality: 50,
                            preferredCameraDevice: CameraDevice.front);
                        setState(() {
                          _image = File(image.path);
                        });
                      },
                      child: _image != null
                          ? Image.file(_image)
                          : const Image(
                              image: AssetImage('Assets/empty_img.png')),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 19,
                    endIndent: 19,
                    color: AppColors.widgetsBackground,
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
