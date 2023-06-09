import 'package:brain_wave_2/feature/neurons/data/main/main_neuron_repository.dart';
import 'package:brain_wave_2/utils/utils.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:brain_wave_2/widgets/buttons/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationNeuron extends StatefulWidget {
  const InformationNeuron({Key? key}) : super(key: key);

  @override
  State<InformationNeuron> createState() => _InformationNeuronState();
}

class _InformationNeuronState extends State<InformationNeuron> {
  @override
  Widget build(BuildContext context) {
    NeuronsRepository neuronRepository =
        RepositoryProvider.of<NeuronsRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Нейросеть"),
        backgroundColor: AppColors.purpleButton,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallAvatar(
                      avatar: neuronRepository.getNeurons()[0].image,
                      name: neuronRepository.getNeurons()[0].name,
                  radius: 40,),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(neuronRepository.getNeurons()[0].name,
                            style: AppTypography.font32white,),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.hashtag,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Expanded(
                          child: Text(
                            '#${neuronRepository.getNeurons()[0].hashtag}',
                            style: AppTypography.font12lightGray,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                neuronRepository.getNeurons()[0].description,
                style: AppTypography.font16description,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    callback: () {
                      Navigator.pushNamed(context, '/neuron_chat');
                    },
                    text: 'Перейти к чату',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
