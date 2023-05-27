import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/elevated_button.dart';
import 'package:brain_wave_2/widgets/filled_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
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
                            hintText: 'Email', controller: emailController),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomFilledTextField(
                            hintText: 'Password', controller: passwordController),
                        const SizedBox(
                          height: 120)
                      ],
                    ),
                    CustomElevatedButton(callback: () {}, text: 'Войти')
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
