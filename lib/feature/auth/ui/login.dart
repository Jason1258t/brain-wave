import 'package:brain_wave_2/feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:brain_wave_2/feature/auth/bloc/registration_bloc/registration_bloc.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/buttons/elevated_button.dart';
import 'package:brain_wave_2/widgets/buttons/google_button.dart';
import 'package:brain_wave_2/widgets/snack_bar/custom_cnack_bar.dart';
import 'package:brain_wave_2/widgets/text_fields/filled_text_field.dart';
import 'package:brain_wave_2/widgets/text_fields/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isErrorEmail = true;
    bool isErrorPassword = true;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          Dialogs.hide(context);
          if (state is AuthLoadingState) {
            Dialogs.showModal(
                context,
                Center(
                  child: AppAnimations.bouncingLine,
                ));
          } else if (state is AuthFailState) {
            CustomSnackBar.showSnackBar(context, 'ошибка');
          } else if (state is AuthSuccessState ||
              state is RegisterSuccessState) {
            CustomSnackBar.showSnackBar(context, 'успешно');
          } else if (state is LoginInvalidFields) {
            isErrorEmail = !state.email;
            isErrorPassword = !state.password;
            CustomSnackBar.showSnackBar(context, 'поля заполнены неверно');
          } else if (state is LoginValidFields) {
            BlocProvider.of<AuthBloc>(context).add(LoginInitialEvent(
                email: emailController.text.trim(),
                password: passwordController.text.trim()));
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: const Color(0xff131124),
              body: SingleChildScrollView(
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
                              'Вход',
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
                              hintText: 'Email',
                              controller: emailController,
                              keyBoardType: TextInputType.emailAddress,
                              isError: isErrorEmail,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomPasswordField(
                                hintText: 'Password',
                                controller: passwordController,
                                isError: isErrorPassword,
                            ),
                            const SizedBox(height: 120)
                          ],
                        ),
                        CustomElevatedButton(
                            callback: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                  LoginCheckValid(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim()));
                            },
                            text: 'Войти'),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register_screen');
                            },
                            child: const Text(
                              'регистрация',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        GoogleElevatedButton(callback: () {BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());}, text: 'продолжить с Google')
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
