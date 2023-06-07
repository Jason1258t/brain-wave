import 'package:brain_wave_2/feature/home/bloc/navigation_bloc.dart';
import 'package:brain_wave_2/feature/neurons/bloc/neurons/neurons_bloc.dart';
import 'package:brain_wave_2/feature/neurons/data/main/main_neuron_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/utils/utils.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:brain_wave_2/widgets/nueron/neuron.dart';
import 'package:brain_wave_2/widgets/text_fields/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NeuronsScreen extends StatefulWidget {
  const NeuronsScreen({Key? key}) : super(key: key);

  @override
  State<NeuronsScreen> createState() => _NeuronsScreenState();
}

class _NeuronsScreenState extends State<NeuronsScreen> {
  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NeuronsBloc>(context).add(NeuronsInitialLoadEvent());
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.background,
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
                    'Нейросети',
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
                hintText: 'Поиск нейросетей',
                controller: queryController,
                callback: (q) {},
                width: MediaQuery.of(context).size.width * 0.8,
                height: 70,
              ),
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<NeuronsBloc, NeuronsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is NeuronsSuccessState) {
                    return Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        clipBehavior: Clip.hardEdge,
                        scrollDirection: Axis.vertical,
                        children: [
                          Column(
                            children: RepositoryProvider.of<NeuronsRepository>(
                                    context)
                                .getNeurons()
                                .map((e) => Neuron(
                                      neuron: e,
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    );
                  } else if (state is NeuronsLoadingState) {
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
    );
  }
}
