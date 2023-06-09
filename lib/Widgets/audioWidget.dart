import 'package:dhamma/Utlis/Loading.dart';

import '../Utlis/EmptyLists.dart';
import '../Widgets/audioDetailWidget.dart';
import '../Helper/fadePageRoute.dart';
import '../Provider/DataProvider.dart';
import 'package:flutter/material.dart';
import '../Modal/Audio.dart';
import 'package:provider/provider.dart';
import '../Screen/Audio.dart' as audioScreen;

class audioWidget extends StatelessWidget {
  const audioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<DataProvider>(context, listen: false)
            .fetchAudioMedias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Loading(width: 120,),
                    );
                  }),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final audidos = Provider.of<DataProvider>(context).audioMedias;
            return audidos.isEmpty
                ? const EmptyList('အသံ တရားတော်မရှိသေးပါဗျာ')
                : SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: audidos.length,
                      itemBuilder: (context, i) {
                      return audio(audidos[i], context);
                    }),
                  );
          }
          return const Center(
            child: Text('What Happending?'),
          );
        });
  }
}

Widget audio(Audio audio, BuildContext context) {
  return Container(
    height: 120,
    width: 120,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10)),
    child: AudioCard(audio: audio),
  );
}
