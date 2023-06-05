import 'package:brain_wave_2/feature/home/bloc/navigation_bloc.dart';
import 'package:brain_wave_2/feature/news/bloc/news_bloc.dart';
import 'package:brain_wave_2/feature/news/data/news_repository.dart';
import 'package:brain_wave_2/logic/app_repository.dart';
import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/utils/utils.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:brain_wave_2/widgets/nueron/neuron.dart';
import 'package:brain_wave_2/widgets/text_fields/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

NeuronModel neuronL = NeuronModel(title: 'Chat gbt', image: 'Assets/chatGBT.png', isLike: true);
NeuronModel neuron = NeuronModel(title: 'Chat gbt', image: 'Assets/chatGBT.png', isLike: false);

List<NeuronModel> neurons = <NeuronModel>[neuronL,neuron,neuronL,neuron,neuronL,neuron,neuronL,neuron,neuronL,neuron,neuronL,neuron];


class NeuronsScreen extends StatefulWidget {
  const NeuronsScreen({Key? key}) : super(key: key);

  @override
  State<NeuronsScreen> createState() => _NeuronsScreenState();
}

class _NeuronsScreenState extends State<NeuronsScreen> {
  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NewsBloc>(context).add(NewsInitialLoadEvent());
    return Container(
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
                            children: neurons.map((e) => Neuron(neuron: e,))
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
    );
  }
}
