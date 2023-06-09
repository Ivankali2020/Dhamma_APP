import 'package:cached_network_image/cached_network_image.dart';
import '../Provider/MusicProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingMusicPlayer extends StatefulWidget {
  @override
  _FloatingMusicPlayerState createState() => _FloatingMusicPlayerState();
}

class _FloatingMusicPlayerState extends State<FloatingMusicPlayer> {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<MusicProvider>(context);
    void play() {
      audioPlayerModel
          .play(audioPlayerModel.audioMedias[audioPlayerModel.activeIndex]);
    }

    void pause() {
      audioPlayerModel.pause();
    }

    void next() {
      audioPlayerModel.next();
    }

    void previous() {
      audioPlayerModel.prev();
    }

    void closeBox() {
      audioPlayerModel.toggleMusicBox();
    }

    return audioPlayerModel.audioMedias.isEmpty || !audioPlayerModel.isShow
        ? FloatingActionButton(onPressed: closeBox,child:const Icon(Icons.music_note_sharp),)
        : Container(
            margin: const EdgeInsets.only(left: 30),
            width: double.infinity,
            height: 86,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                Positioned(
                  top:10,
                  bottom:0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   width: 40,
                      //   height: 40,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: CachedNetworkImage(
                      //         placeholder: (context, url) =>
                      //             CircularProgressIndicator(),
                      //         imageUrl:
                      //             'https://cdn3d.iconscout.com/3d/premium/thumb/sound-recorder-6546335-5376598.png?f=avif'),
                      //   ),
                      // ),
                      audioPlayerModel.isLoading
                          ? const SizedBox(
                              width: 160,
                              height: double.infinity,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(audioPlayerModel.name),
                                  Slider(
                                    min: 0.0,
                                    max: audioPlayerModel.dur,
                                    value: audioPlayerModel.progress,
                                    onChanged: (value) {
                                      audioPlayerModel.player.seek(
                                        Duration(
                                          milliseconds:
                                              audioPlayerModel.progress.round(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                          ),
                      // this is for prev
                      audioPlayerModel.activeIndex == 0
                          ? const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.skip_previous,
                                color: Colors.grey,
                              ),
                              disabledColor: Colors.grey,
                            )
                          : IconButton(
                              onPressed: previous,
                              icon: const Icon(Icons.skip_previous),
                              disabledColor: Colors.grey,
                            ),

                      // this is for paly and pause
                      audioPlayerModel.player.playing
                          ? IconButton(
                              onPressed: pause,
                              icon: const Icon(Icons.pause_circle))
                          : IconButton(
                              onPressed: play,
                              icon: const Icon(Icons.play_circle)),

                      // this is for next
                      audioPlayerModel.activeIndex ==
                              audioPlayerModel.audioMedias.length - 1
                          ? const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.skip_next,
                                color: Colors.grey,
                              ),
                              disabledColor: Colors.grey,
                            )
                          : IconButton(
                              onPressed: next,
                              icon: const Icon(Icons.skip_next),
                            ),
                    ],
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: IconButton(
                    splashRadius: 20,
                    onPressed: closeBox,
                    icon:const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
