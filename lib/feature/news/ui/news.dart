import 'package:brain_wave_2/feature/home/bloc/navigation_bloc.dart';
import 'package:brain_wave_2/feature/news/bloc/news_bloc.dart';
import 'package:brain_wave_2/feature/news/data/news_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/utils.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:brain_wave_2/widgets/text_fields/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/post/post.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(NewsInitialLoadEvent());
    return Scaffold(
      floatingActionButton: const Icon(Icons.pending_actions_sharp),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff131124),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 13, left: 30, right: 30),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Новости',
                      style: AppTypography.font24lightBlue,
                    ),
                    GestureDetector(
                      onTap: () async {
                        BlocProvider.of<NavigationBloc>(context)
                            .add(ViewProfileEvent());
                      },
                      child: SmallAvatar(
                          avatar: RepositoryProvider.of<AppRepository>(context)
                                  .getCurrentUser()!
                                  .photoURL ??
                              '',
                          name: RepositoryProvider.of<AppRepository>(context)
                              .getCurrentUser()!
                              .displayName!),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomSearchField(
                  hintText: 'что ищем',
                  controller: queryController,
                  callback: (q) {},
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<NewsBloc, NewsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is NewsSuccessState) {
                      return Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast),
                          clipBehavior: Clip.hardEdge,
                          scrollDirection: Axis.vertical,
                          children: [
                            Column(
                              children:
                                  RepositoryProvider.of<NewsRepository>(context)
                                      .getNews()
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 21, 0, 21),
                                            child: Post(post: e),
                                          ))
                                      .toList(),
                            )
                          ],
                        ),
                      );
                    } else if (state is NewsLoadingState) {
                      return const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator());
                    } else {
                      return const Text('Проблемс');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
