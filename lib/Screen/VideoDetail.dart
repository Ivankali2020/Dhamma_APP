import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import '../Modal/Video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  final Video video;

  const VideoDetail(this.video);

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.video);
    _controller.initialize().then((value) {
      chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: false,
        showControls: true,
        autoInitialize: true,
      );
      setState(() {
        _controller.play();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    chewieController.dispose();
  }

  void play() {
    setState(() {
      _controller.play();
    });
    print(widget.video.video);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.video.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Chewie(
                        controller: chewieController,
                      ),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                          value: progress.progress),
                                    ),
                            fit: BoxFit.cover,
                            imageUrl: widget.video.thumbnail),
                      ),
                    ),
                    const Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      top: 0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
