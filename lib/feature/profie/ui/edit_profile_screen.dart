import 'package:brain_wave_2/feature/profie/bloc/profile_bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/buttons/elevated_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
            title: Text('Изменить $titleAlertDialog', style: AppTypography.font18lightBlue,),
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
    BlocProvider.of<ProfileBloc>(context).add(ProfilePostsInitialLoadEvent());
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
      body: Container(
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
                _Avatar(
                  avatar: '',
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      paddingWidthMainSize, 20, paddingWidthMainSize, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: const Color(0xff272850),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Имя:',
                                  style: AppTypography.font18lightBlue,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: const Text(
                                    '2asdfasdfasdfasdfasasdfasdfasdfdfasdf',
                                    style: AppTypography.font18lightBlue,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _displayTextInputDialog(
                                        context,
                                        emailController,
                                        'email',
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.pending_actions_sharp,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Email:',
                                  style: AppTypography.font18lightBlue,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: const Text(
                                    '2asdfasdfasdfasdfasasdfasdfasdfdfasdf',
                                    style: AppTypography.font18lightBlue,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _displayTextInputDialog(
                                        context,
                                        nameController,
                                        'email',
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.pending_actions_sharp,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                if (1 != 1) ...[
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
                        SizedBox(
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
                        SizedBox(
                          height: 35,
                        ),
                        CustomElevatedButton(
                          width: MediaQuery.of(context).size.width * 0.8,
                          callback: () {},
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
                        SizedBox(
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
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  String avatar;

  _Avatar({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xff0057FF),
      radius: 71,
      child: CircleAvatar(
        backgroundColor: const Color(0xff131124),
        radius: 69,
        child: CircleAvatar(
          backgroundImage:
              AssetImage(avatar == '' ? 'Assets/ProfileImage.png' : avatar),
          backgroundColor: Colors.white,
          radius: 62,
        ),
      ),
    );
  }
}
