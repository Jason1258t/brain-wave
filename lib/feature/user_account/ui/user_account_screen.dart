import 'package:brain_wave_2/feature/profie/data/profile_repository.dart';
import 'package:brain_wave_2/feature/user_account/data/user_account_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/avatars/profile_avatar.dart';
import 'package:brain_wave_2/widgets/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/buttons/elevated_button.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    final mainRepository = RepositoryProvider.of<AppRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('лол'), // TODo имя user
        centerTitle: true,
        backgroundColor: AppColors.purpleButton,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 24, 0, 22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileAvatar(
                    avatar: mainRepository.getCurrentUser()!.photoURL ?? '',
                    name: mainRepository.getCurrentUser()!.displayName!,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,15, 0,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('name', style: AppTypography.font24lightBlue,), // TODo имя user
                        const SizedBox(height: 10,),
                        const Text('email', style: AppTypography.font18lightBlue,),// TODo имя eamil
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  32, 10, 32, 19),
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
            Center(
              child: CustomElevatedButton(
                callback: () {  },
                text: 'написать',
              ),
            ),
            const SizedBox(height: 15,),
            const Divider(thickness: 1, color: AppColors.purpleButton, endIndent: 16, indent: 16,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async{},
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  clipBehavior: Clip.hardEdge,
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      children:
                      RepositoryProvider.of<ProfileRepository>( //TODO post by person
                          context)
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
