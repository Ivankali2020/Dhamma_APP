import '../Modal/Audio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicProvider with ChangeNotifier {
  late List<Audio> audioMedias;

  MusicProvider(this.audioMedias);

  final player = AudioPlayer();
  late double progress = 0.00;
  late double dur = 0.00;
  late String name = 'အသံတရားတော်';
  late bool isLoading = false;
  late int activeIndex = 0;
  late bool isShow = false;
  Audio? singleAudio;

  Future<void> play(Audio audio) async {
    if (progress != 0.00 && name == audio.name) {
      player.seek(Duration(seconds: progress.toInt()));
      player.play();
      singleAudio = audio;
      return;
    }

    if (audioMedias.where((element) => element.id == audio.id).isEmpty) {
      audioMedias.add(audio);
    }

    playCore(audio);
  }

  Future<void> playCore(Audio audio) async {

    isShow = true;
    isLoading = true;
    final duration = await player.setUrl(audio.audio);
    dur = duration!.inSeconds.toDouble();
    name = audio.name;

    singleAudio = audio;

    activeIndex = audioMedias.indexWhere((element) => element.id == audio.id);

    player.positionStream.listen((position) {
      progress = position.inSeconds.toDouble();
      if (progress == dur) {
        player.pause();
        singleAudio = null;
        notifyListeners();
      }
      notifyListeners();
    });
    player.play();

    isLoading = false;
    notifyListeners();
  }

  Future pause() async {
    player.pause();

    singleAudio = null;
    notifyListeners();
  }

  Future next() async {
    if (activeIndex == audioMedias.length) {
      return;
    }
    final audio = audioMedias[activeIndex + 1];
    playCore(audio);

    activeIndex++;
  }

  Future prev() async {
    if (activeIndex == 0) {
      return;
    }
    final audio = audioMedias[activeIndex - 1];
    playCore(audio);

    activeIndex--;
  }

  void toggleMusicBox() {
    isShow = !isShow;
    notifyListeners();
  }
}
