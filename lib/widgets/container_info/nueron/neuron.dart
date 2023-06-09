import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
import 'package:brain_wave_2/widgets/avatars/small_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Neuron extends StatefulWidget {
  NeuronModel neuron;
  double height;
  Neuron({Key? key, required this.neuron, this.height = 80}) : super(key: key);

  @override
  State<Neuron> createState() => _NeuronState();
}

class _NeuronState extends State<Neuron> {
  List<TextSpan> _createRichText(List<String> list) {
    List<TextSpan> richtext = [];
    for (var i = 0; i < list.length ; i++) {
      richtext.add(TextSpan(text: '#${list[i]}', style: AppTypography.teg));
      richtext.add(const TextSpan(text: ' '));
    }
    return richtext;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/neuron_info');
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: widget.height,
          decoration: const BoxDecoration(
            color: AppColors.widgetsBackground,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallAvatar(avatar: widget.neuron.image, name: widget.neuron.name),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.neuron.name,
                      style: AppTypography.font24lightBlue,
                    ),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: RichText(
                        text: TextSpan(
                          children: _createRichText(widget.neuron.hashtag),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    _createRichText(widget.neuron.hashtag);
                  },
                  icon: Icon(
                    widget.neuron.isLike
                        ? FontAwesomeIcons.heartCrack
                        : FontAwesomeIcons.heart,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
