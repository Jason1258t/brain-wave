import 'package:brain_wave_2/logic/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {BlocProvider.of<AppBloc>(context).add(AppLogOutEvent());},
          child: const Text('выйти'),
        ),
      ),
    );
  }
}
