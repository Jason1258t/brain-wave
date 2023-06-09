import 'dart:developer';

import 'package:brain_wave_2/feature/add_neuron/data/neron_creating_repository.dart';
import 'package:brain_wave_2/feature/add_neuron/ui/add_nueron_screen.dart';
import 'package:brain_wave_2/feature/add_post/bloc/add_post_bloc.dart';
import 'package:brain_wave_2/feature/add_post/data/creating_post_repository.dart';
import 'package:brain_wave_2/feature/add_post/ui/add_post_screen.dart';
import 'package:brain_wave_2/feature/home/bloc/navigation_bloc.dart';
import 'package:brain_wave_2/feature/neurons/bloc/message/message_bloc.dart';
import 'package:brain_wave_2/feature/neurons/bloc/neurons/neurons_bloc.dart';
import 'package:brain_wave_2/feature/neurons/data/chat/chat_repository.dart';
import 'package:brain_wave_2/feature/neurons/data/main/main_neuron_repository.dart';
import 'package:brain_wave_2/feature/neurons/ui/chat_neuron.dart';
import 'package:brain_wave_2/feature/neurons/ui/information_neuron.dart';
import 'package:brain_wave_2/feature/neurons/ui/neurons_screen.dart';
import 'package:brain_wave_2/feature/news/bloc/news_bloc.dart';
import 'package:brain_wave_2/feature/news/data/news_repository.dart';
import 'package:brain_wave_2/feature/profie/bloc/profile_bloc.dart';
import 'package:brain_wave_2/feature/profie/bloc/profile_update/profile_update_bloc.dart';
import 'package:brain_wave_2/feature/profie/data/profile_repository.dart';
import 'package:brain_wave_2/feature/profie/ui/edit_profile_screen.dart';
import 'package:brain_wave_2/feature/user_account/bloc/user_account_bloc.dart';
import 'package:brain_wave_2/feature/user_account/data/user_account_repository.dart';
import 'package:brain_wave_2/feature/user_account/ui/user_account_screen.dart';
import 'package:brain_wave_2/feature/user_chats/data/user_chats_repository.dart';
import 'package:brain_wave_2/feature/user_chats/ui/users_screen.dart';
import 'package:brain_wave_2/logic/app_bloc.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/services/api_service.dart';
import 'package:brain_wave_2/services/custom_bloc_observer.dart';
import 'package:brain_wave_2/services/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
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
        '/register_screen': (context) => FirstRegistrationScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/main_screen': (context) => const MainScreen(),
        '/edit_profile_screen': (context) => const EditProfile(),
        '/neurons': (context) => const NeuronsScreen(),
        '/neuron_chat': (context) => const ChatNeuron(),
        '/neuron_info': (context) => const InformationNeuron(),
        '/add_post': (context) => const AddPost(),
        '/chat_user': (context) => const UsersPage(),
        '/add_neuron': (context) => const AddNeuron(),
        '/user_account_screen': (context) => const UserAccount(),
      },
      home: const HomePage(),
    );
  }
}

class MyRepositoryProviders extends StatelessWidget {
  MyRepositoryProviders({Key? key}) : super(key: key);
  final apiService = ApiService(firestore: FirebaseFirestore.instance);
  final firebaseAuth = FirebaseAuthService();
  final chatCore = FirebaseChatCore.instance;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
          create: (_) => AppRepository(
              firebaseAuthService: firebaseAuth, chatCore: chatCore)),
      RepositoryProvider(
          create: (_) => ProfileRepository(apiService: apiService)),
      RepositoryProvider(create: (_) => NewsRepository(apiService: apiService)),
      RepositoryProvider(create: (_) => ChatRepository()),
      RepositoryProvider(
          create: (_) => NeuronsRepository(apiService: apiService)),
      RepositoryProvider(create: (_) => UserChatsRepository()),
      RepositoryProvider(
          create: (_) => PostCreatingRepository(apiService: apiService)),
      RepositoryProvider(
          create: (_) => NeuronCreatingRepository(apiService: apiService)),
      RepositoryProvider(
          create: (_) => UserAccountRepository(apiService: apiService))
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
              newsRepository: RepositoryProvider.of<NewsRepository>(context))
            ..add(NewsSubscribeEvent())),
      BlocProvider(lazy: false, create: (_) => NavigationBloc()),
      BlocProvider(
          lazy: false,
          create: (_) => ProfileUpdateBloc(
              appRepository: RepositoryProvider.of<AppRepository>(context))
            ..add(UpdatingSubscribeEvent())),
      BlocProvider(
          lazy: false,
          create: (_) => MessageBloc(
              chatRepository: RepositoryProvider.of<ChatRepository>(context))
            ..add(MessageSubscribeEvent())),
      BlocProvider(
          lazy: false,
          create: (_) => NeuronsBloc(
              neuronsRepository:
                  RepositoryProvider.of<NeuronsRepository>(context))
            ..add(NeuronsSubscribeEvent())),
      BlocProvider(
          lazy: false,
          create: (_) => AddPostBloc(
              postCreatingRepository:
                  RepositoryProvider.of<PostCreatingRepository>(context))
            ..add(AddPostSubscribeEvent())),
      BlocProvider(
          lazy: false,
          create: (_) => UserAccountBloc(
              accountRepository:
                  RepositoryProvider.of<UserAccountRepository>(context))
            ..add(UserSubscribeEvent())),
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
