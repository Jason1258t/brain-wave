import 'package:brain_wave_2/feature/user_account/data/user_account_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/widgets/avatars/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    final mainRepository = RepositoryProvider.of<AppRepository>(context);
    final userAccountRepository =
        RepositoryProvider.of<UserAccountRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('лол'), // TODo имя user
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ProfileAvatar(
              avatar: mainRepository.getCurrentUser()!.photoURL ?? '',
              name: mainRepository.getCurrentUser()!.displayName!,
            ),
          ],
        ),
      ),
    );
  }
}
