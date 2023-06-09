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
  List<TextSpan> _createRichText(List<String> list) {
    List<TextSpan> richtext = [];
    for (var i = 0; i < list.length ; i++) {
      richtext.add(TextSpan(text: '#${list[i]}', style: AppTypography.teg));
      richtext.add(const TextSpan(text: ' '));
    }
    return richtext;
  }

  int maxLines = 2;

  void changeMaxLines() {
    setState(() {
      if (maxLines == 2) {
        maxLines = 90;
      } else {
        maxLines = 2;
      }

    });
  }

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
                      InkWell(
                        onTap: changeMaxLines,
                        child: SizedBox(
                          width: 150,
                          child: RichText(
                            softWrap: true,
                            maxLines: maxLines,
                            text: TextSpan(

                              children: _createRichText(neuronRepository.getNeurons()[0].hashtag),
                            ),
                            overflow: TextOverflow.ellipsis,
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
