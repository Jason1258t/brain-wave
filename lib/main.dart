import 'package:brain_wave_2/auth/bloc/auth_bloc.dart';
import 'package:brain_wave_2/auth/ui/first_registration_screen.dart';
import 'package:brain_wave_2/auth/ui/login.dart';
import 'package:brain_wave_2/home/ui/main_screen.dart';
import 'package:brain_wave_2/logic/app_bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/services/custom_bloc_observer.dart';
import 'package:brain_wave_2/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyRepositoryProviders());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      routes: {
        '/register_first': (context) => const FirstRegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/register_second': (context) => const HomePage()
      },
      home: const HomePage(),
    );
  }
}

class MyRepositoryProviders extends StatelessWidget {
  MyRepositoryProviders({Key? key}) : super(key: key);
  final firebaseAuth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
          create: (_) => AppRepository(firebaseAuthService: firebaseAuth)),
    ], child: const MyBlocProviders());
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          lazy: false,
          create: (_) => AuthBloc(
              appRepository: RepositoryProvider.of<AppRepository>(context))
            ..add(AuthSubscriptionEvent())),
      BlocProvider(
          lazy: false,
          create: (_) => AppBloc(
              appRepository: RepositoryProvider.of<AppRepository>(context))
            ..add(AppSubscribeEvent())),
    ], child: const MyApp());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AppAuthState) return const MainScreen();
          if (state is AppAuthState) {
            return const LoginScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
