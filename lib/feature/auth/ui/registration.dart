
import 'package:brain_wave_2/feature/auth/bloc/registration_bloc/registration_bloc.dart';
import 'package:brain_wave_2/widgets/buttons/elevated_button.dart';
import 'package:brain_wave_2/widgets/filled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';


class FirstRegistrationScreen extends StatelessWidget {
  const FirstRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController firstPasswordController =
        TextEditingController();
    final TextEditingController secondPasswordController =
        TextEditingController();
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff131124),
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is ValidRegState) {
            BlocProvider.of<RegistrationBloc>(context).add(RegisterInitialEvent(
                email: emailController.text.trim(),
                password: firstPasswordController.text.trim(),
            name: nameController.text.trim()));
            BlocProvider.of<RegistrationBloc>(context).add(RegisterCompleteEvent());
          } else if (state is FirstRegScreenInvalid) {
            const snackBar = SnackBar(content: Text('неверно введена инфа'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is RegisterSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
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
                          height: 50,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomFilledTextField(
                          hintText: 'Имя',
                          controller: nameController,
                          keyBoardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomFilledTextField(
                            hintText: 'Email', controller: emailController),
                        const SizedBox(height: 25),
                        CustomFilledTextField(
                          hintText: 'password',
                          controller: firstPasswordController,
                          keyBoardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomFilledTextField(
                            hintText: 'repeat password',
                            controller: secondPasswordController),
                        const SizedBox(height: 40)
                      ],
                    ),
                    CustomElevatedButton(
                        callback: () {
                          BlocProvider.of<RegistrationBloc>(context).add(
                              RegFirstScreenCheckValid(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  firstPassword: firstPasswordController.text.trim(),
                                  secondPassword:
                                      secondPasswordController.text.trim()));
                        },
                        text: 'Регистрация'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'вход',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ))
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
