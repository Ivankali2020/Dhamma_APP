import '../Modal/Audio.dart';
import '../Provider/AudioProvider.dart';
import '../Widgets/audioDetailWidget.dart';
import '../Widgets/floatingMusicPlayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioDetail extends StatelessWidget {
  final int subCategoryId;
  final String subCategroyName;
  AudioDetail(this.subCategoryId,this.subCategroyName);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text(subCategroyName),
      ),
      body: FutureBuilder(
        future: Provider.of<AudioProvider>(context, listen: false)
            .fetchAudioMediasBySubCategory(subCategoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<Audio> audios =
                Provider.of<AudioProvider>(context).audioMedias;
            return audios.isEmpty
                ? const Center(
                    child: Text('မတွေ့ရှိပါ ခင်ဗျာ'),
                  )
                : audioDetailWidget(audios);
          }

          return const Center(
            child: Text('What Happened?'),
          );
        },
      ),
      floatingActionButton: FloatingMusicPlayer(),
    );
  }
}
