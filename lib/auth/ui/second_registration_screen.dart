import 'package:brain_wave_2/auth/bloc/auth_bloc.dart';
import 'package:brain_wave_2/widgets/elevated_button.dart';
import 'package:brain_wave_2/widgets/filled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';

class FirstRegistrationScreen extends StatelessWidget {
  const FirstRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstPasswordController = TextEditingController();
    final TextEditingController secondPasswordController = TextEditingController();
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff131124),
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Text(
                              'Brain Wave',
                              style: AppTypography.font32fff,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Регистрация',
                              style: AppTypography.font204F6BFF,
                            ),
                            SizedBox(
                              height: 110,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomFilledTextField(
                              hintText: 'password',
                              controller: firstPasswordController,
                              keyBoardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomFilledTextField(
                                hintText: 'repeat password', controller: secondPasswordController),
                            const SizedBox(height: 120)
                          ],
                        ),
                        CustomElevatedButton(callback: () {}, text: 'Войти'),
                        const SizedBox(height: 10,),
                        TextButton(onPressed: () {Navigator.pushNamed(context, '/login');}, child: const Text('вход', style: TextStyle(color: Colors.white, fontSize: 14),))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
