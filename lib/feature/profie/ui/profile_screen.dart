import 'package:brain_wave_2/feature/profie/bloc/profile_bloc.dart';
import 'package:brain_wave_2/feature/profie/data/profile_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/buttons/icon_text_button.dart';
import 'package:brain_wave_2/widgets/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/app_bloc.dart';
import '../../../models/post_model.dart';

PostModel _post = PostModel(
    creatorName: 'лошара',
    title: 'первый пост',
    description:
        'Безусловно, базовый вектор развития играет определяющее значение для направлений прогрессивного развития',
    image: 'Assets/openAi.png',
    creatorImage: 'Assets/ProfileImage.png');
var list = [
  _post,
  _post,
  _post,
  _post,
];

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    void logoutShowDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.widgetsBackground,
              title: const Text(
                'Уверены что хотите выйти?',
                style: AppTypography.font18lightBlue,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<AppBloc>(context)
                              .add(AppLogOutEvent());
                          Navigator.pop(context);
                        },
                        child: const Text('Да')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Эээ куда'))
                  ],
                )
              ],
            );
          });
    }

    final repository = RepositoryProvider.of<AppRepository>(context);
    BlocProvider.of<ProfileBloc>(context).add(ProfilePostsInitialLoadEvent());
    final double paddingWidthMainSize =
        MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleButton,
        title: const Text(
          'Профиль',
          style: TextStyle(fontSize: 20),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              title: const Text(
                'Закрыть',
                style: AppTypography.font18lightBlue,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: const Text(
                  'Выйти',
                  style: AppTypography.font18red,
                ),
                onTap: logoutShowDialog),
          ]).toList(),
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
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    repository.getCurrentUser()!.displayName!,
                    style: AppTypography.font24lightBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    repository.getCurrentUser()!.email!,
                    style: AppTypography.font18lightBlue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      paddingWidthMainSize, 10, paddingWidthMainSize, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 85,
                    decoration: BoxDecoration(
                      color: const Color(0xff272850),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Избранные нейронки:',
                                style: AppTypography.font18lightBlue,
                              ),
                              Text(
                                '10',
                                style: AppTypography.font18lightBlue,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Посты:',
                                style: AppTypography.font18lightBlue,
                              ),
                              Text(
                                '2',
                                style: AppTypography.font18lightBlue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconTextButton(
                  title: 'Опубликовать',
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline),
                  borderRadius: 15,
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.85,
                ),
                BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfilePostsSuccessState) {
                      return Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast),
                          clipBehavior: Clip.hardEdge,
                          scrollDirection: Axis.vertical,
                          children: [
                            Column(
                              children:
                                  RepositoryProvider.of<ProfileRepository>(context)
                                      .usersPosts
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 21, 0, 21),
                                            child: Post(post: e),
                                          ))
                                      .toList(),
                            )
                          ],
                        ),
                      );
                    } else if (state is ProfilePostsLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text('Проблемс');
                    }
                  },
                )
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
