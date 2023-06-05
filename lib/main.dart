import 'dart:developer';

import 'package:brain_wave_2/feature/home/bloc/navigation_bloc.dart';
import 'package:brain_wave_2/feature/news/bloc/news_bloc.dart';
import 'package:brain_wave_2/feature/news/data/news_repository.dart';
import 'package:brain_wave_2/feature/profie/bloc/profile_bloc.dart';
import 'package:brain_wave_2/feature/profie/data/profile_repository.dart';
import 'package:brain_wave_2/logic/app_bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:brain_wave_2/services/custom_bloc_observer.dart';
import 'package:brain_wave_2/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'feature/auth/bloc/auth_bloc/auth_bloc.dart';
import 'feature/auth/bloc/registration_bloc/registration_bloc.dart';
import 'feature/auth/ui/registration.dart';
import 'feature/auth/ui/login.dart';
import 'feature/home/ui/main_screen.dart';
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
      title: 'Brain Wave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        canvasColor: const Color(0xff292B57),
      ),
      color: const Color(0xff292B57),
      routes: {
        '/register_first': (context) => FirstRegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/main_screen': (context) => const MainScreen(),
      },
      home: const HomePage(),
    );
  }
}

class MyRepositoryProviders extends StatelessWidget {
  MyRepositoryProviders({Key? key}) : super(key: key);
  final firebaseAuth = FirebaseAuthService();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
          create: (_) => AppRepository(firebaseAuthService: firebaseAuth)),
      RepositoryProvider(
          create: (_) => ProfileRepository(apiService: apiService)),
      RepositoryProvider(create: (_) => NewsRepository(apiService: apiService)),
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
              appRepository: RepositoryProvider.of<AppRepository>(context),
              profileRepository:
                  RepositoryProvider.of<ProfileRepository>(context))
            ..add(AppSubscribeEvent())),
      BlocProvider(
          lazy: false,
          create: (_) => RegistrationBloc(
              appRepository: RepositoryProvider.of<AppRepository>(context))
            ..add(RegisterSubscribeEvent())),
      BlocProvider(
          lazy: false,
          create: (_) => ProfileBloc(
              profileRepository:
                  RepositoryProvider.of<ProfileRepository>(context))
            ..add(ProfileSubscribeEvent())),
      BlocProvider(
        lazy: false,
        create: (_) => NewsBloc(
            newsRepository: RepositoryProvider.of<NewsRepository>(context))..add(NewsSubscribeEvent())),
      BlocProvider(
        lazy: false,
        create: (_) => NavigationBloc()),
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
          log(state.toString());
          if (state is AppAuthState) return const MainScreen();
          if (state is AppUnAuthState) {
            return const LoginScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
