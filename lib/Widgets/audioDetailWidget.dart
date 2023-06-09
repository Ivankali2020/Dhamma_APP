import '../Modal/Audio.dart';
import '../Provider/MusicProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class audioDetailWidget extends StatelessWidget {
  final List<Audio> audios;
  audioDetailWidget(this.audios);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
          ),
          itemCount: audios.length,
          itemBuilder: (context, i) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: AudioCard(
                audio: audios[i],
              ),
            );
          }),
    );
  }
}

class AudioCard extends StatelessWidget {
  const AudioCard({
    super.key,
    required this.audio,
  });

  final Audio audio;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SvgPicture.asset(
            'assets/buddha.svg',
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: Center(
            child:
                audio.id == Provider.of<MusicProvider>(context).singleAudio?.id
                    ? IconButton(
                        onPressed: () {
                          Provider.of<MusicProvider>(context, listen: false)
                              .pause();
                        },
                        icon: const Icon(Icons.pause_circle_filled),
                      )
                    : IconButton(
                        onPressed: () {
                          Provider.of<MusicProvider>(context, listen: false)
                              .play(audio);
                        },
                        icon: const Icon(Icons.play_circle_fill_outlined),
                      ),
          ),
        ),
        Positioned(
          left: 5,
          bottom: 5,
          child: FittedBox(
            child: Center(
                child: Text(
              audio.duration,
              style: const TextStyle(fontSize: 13),
            )),
          ),
        )
      ],
    );
  }
}
