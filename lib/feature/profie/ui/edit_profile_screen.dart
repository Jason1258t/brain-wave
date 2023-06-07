import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:brain_wave_2/feature/profie/bloc/profile_bloc.dart';
import 'package:brain_wave_2/feature/profie/bloc/profile_update/profile_update_bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/animations.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/dialogs.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/avatars/profile_avatar.dart';
import 'package:brain_wave_2/widgets/snack_bar/custom_cnack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/buttons/elevated_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff272850),
            title: Text(
              'Изменить $titleAlertDialog',
              style: AppTypography.font18lightBlue,
            ),
            content: TextField(
              onChanged: (value) {},
              controller: controller,
              style: AppTypography.font18lightBlue,
            ),
            actions: <Widget>[
              MaterialButton(
                color: AppColors.purpleButton,
                textColor: AppColors.lightBlueText,
                child: const Text('Сохранить'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    BlocProvider.of<ProfileUpdateBloc>(context)
                        .add(UpdateNameEvent(name: controller.text.trim()));
                    setState(() {});
                  });
                },
              )
            ],
          );
        });
  }

  bool verificationInProcess = false;

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<AppRepository>(context);
    void updater() async {
      if (!repository.getCurrentUser()!.emailVerified) {
        CustomSnackBar.showSnackBar(
            context, 'Письмо для подтверждения отправлено');
        setState(() {
          verificationInProcess = true;
        });
        repository.verifyEmail();
        Timer.periodic(
          const Duration(seconds: 5),
          (Timer timer) {
            setState(() {});
            if (repository.getCurrentUser()!.emailVerified) timer.cancel();
          },
        );
      }
    }

    final double paddingWidthMainSize =
        MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleButton,
        title: const Text(
          'Редактирование профиля',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocConsumer<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state) {
          if (state is UpdateLoadingState) {
            Dialogs.showModal(context, AppAnimations.bouncingSquare);
          }

          if (state is UpdateSuccessState) {
            CustomSnackBar.showSnackBar(context, 'успешно');
            Dialogs.hide(context);
          }
          if (state is UpdateFailState) {
            CustomSnackBar.showSnackBar(context, 'что-то пошло по жопе');
            Dialogs.hide(context);

          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff131124),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          var source = ImageSource.gallery;
                          XFile image = await imagePicker.pickImage(
                              source: source,
                              imageQuality: 50,
                              preferredCameraDevice: CameraDevice.front);
                          setState(() {
                            _image = File(image.path);
                            log(image.path.toString());
                            repository.changePhoto(File(image.path));
                          });

                        },
                        child: ProfileAvatar(
                          avatar: repository.getCurrentUser()!.photoURL ?? '',
                          name: repository.getCurrentUser()!.displayName!,
                        ),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          paddingWidthMainSize, 20, paddingWidthMainSize, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        decoration: BoxDecoration(
                          color: const Color(0xff272850),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Имя:',
                                  style: AppTypography.font18lightBlue,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    repository.getCurrentUser()!.displayName!,
                                    style: AppTypography.font18lightBlue,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _displayTextInputDialog(
                                        context,
                                        nameController,
                                        'Имя',
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_note,
                                      color: AppColors.lightBlueText,
                                      size: 30,
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Email:',
                                  style: AppTypography.font18lightBlue,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    repository.getCurrentUser()!.email!,
                                    style: AppTypography.font18lightBlue,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    if (!repository.getCurrentUser()!.emailVerified) ...[
                      // TODO тут должна быть проверка
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Подтверждение email',
                              style: AppTypography.font24lightBlue,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                Text(
                                  'email не подтвержден',
                                  style: AppTypography.font18lightBlue,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            verificationInProcess
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: AppColors.purpleButton,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14))),
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: updater,
                                          child: const Text(
                                            'отправить заново',
                                            style: TextStyle(
                                                color: AppColors.lightBlueText),
                                          ))
                                    ],
                                  )
                                : CustomElevatedButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    callback: updater,
                                    text: 'подтвердите почту',
                                    styleText: AppTypography.font24lightBlue,
                                  ),
                          ],
                        ),
                      )
                    ] else ...[
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Подтверждение email',
                              style: AppTypography.font24lightBlue,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.check,
                                  color: AppColors.checkIcon,
                                ),
                                Text(
                                  'email подтвержден',
                                  style: AppTypography.font18lightBlue,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
