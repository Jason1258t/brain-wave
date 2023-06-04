import 'package:brain_wave_2/feature/auth/bloc/registration_bloc/registration_bloc.dart';
import 'package:brain_wave_2/widgets/buttons/elevated_button.dart';
import 'package:brain_wave_2/widgets/text_fields/filled_text_field.dart';
import 'package:brain_wave_2/widgets/text_fields/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

class FirstRegistrationScreen extends StatefulWidget {
  FirstRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<FirstRegistrationScreen> createState() => _FirstRegistrationScreenState();
}

class _FirstRegistrationScreenState extends State<FirstRegistrationScreen> {
  bool isErrorName = true;

  bool isErrorEmail = true;

  bool isErrorPassword = true;

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
            BlocProvider.of<RegistrationBloc>(context)
                .add(RegisterCompleteEvent());
          } else if (state is FirstRegScreenInvalid) {
            const snackBar = SnackBar(content: Text('неверно введена инфа'));
            isErrorName = !state.name;
            isErrorEmail = !state.email;
            isErrorPassword = !state.password;
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
                          isError: isErrorName,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomFilledTextField(
                          hintText: 'Email',
                          controller: emailController,
                          isError: isErrorEmail,
                        ),
                        const SizedBox(height: 25),
                        CustomPasswordField(
                          hintText: 'password',
                          controller: firstPasswordController,
                          keyBoardType: TextInputType.emailAddress,
                          isError: isErrorPassword,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomPasswordField(
                          hintText: 'repeat password',
                          controller: secondPasswordController,
                          isError: isErrorPassword,
                        ),
                        const SizedBox(height: 40)
                      ],
                    ),
                    CustomElevatedButton(
                        callback: () {
                          BlocProvider.of<RegistrationBloc>(context).add(
                              RegFirstScreenCheckValid(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  firstPassword:
                                      firstPasswordController.text.trim(),
                                  secondPassword:
                                      secondPasswordController.text.trim()));
                          setState(() {});
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
