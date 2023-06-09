import 'package:brain_wave_2/models/neuron_model.dart';
import 'package:brain_wave_2/utils/colors.dart';
import 'package:brain_wave_2/utils/fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: () {Navigator.pushNamed(context, '/neuron_info');},
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
                Image.asset(widget.neuron.image),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.neuron.name, style: AppTypography.font24lightBlue,),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.hashtag,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Expanded(
                        child: Text(
                          '#${widget.neuron.hashtag}',
                          style: AppTypography.font12lightGray,
                        ),
                      ),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(widget.neuron.isLike ? FontAwesomeIcons.heartCrack : FontAwesomeIcons.heart, color: Colors.white,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
