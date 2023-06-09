import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import '../Modal/BLog.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class blogDetail extends StatefulWidget {
  final Blog blog;
  blogDetail(this.blog);

  @override
  State<blogDetail> createState() => _blogDetailState();
}

class _blogDetailState extends State<blogDetail> {
  VideoPlayerController? _controller;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    if (widget.blog.video != null) {
      setUrlVideo(widget.blog.video);
    }
  }

  void setUrlVideo(url) {
    _controller = VideoPlayerController.network(url);

    _controller!.initialize().then((value) {
      chewieController = ChewieController(
        videoPlayerController: _controller!,
        autoPlay: true,
        looping: false,
        showControls: true,
        autoInitialize: true,
      );
      play();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
    }
    if (chewieController != null) {
      chewieController!.dispose();
    }
  }

  void play() {
    setState(() {
      _controller!.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.blog.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _controller != null
                ?
                _controller!.value.isInitialized
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        height: 300,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                :
            CarouselSlider.builder(
                itemCount: widget.blog.photos.length,
                itemBuilder: (context, i, g) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        progressIndicatorBuilder:
                            (context, url, progress) => Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        fit: BoxFit.cover,
                        imageUrl: widget.blog.photos[i],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlayAnimationDuration:const Duration(seconds: 1),
                ),
              ),
            Text(widget.blog.description ?? ''),
          ],
        ),
      ),
    );
  }
}
