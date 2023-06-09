import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhamma/Utlis/Loading.dart';
import 'package:dhamma/Utlis/Logo.dart';
import 'package:shimmer/shimmer.dart';
import '../Helper/fadePageRoute.dart';
import '../Modal/Video.dart';
import '../Provider/DataProvider.dart';
import '../Screen/VideoDetail.dart';
import '../Screen/Video.dart' as videoScreen;
import '../Utlis/EmptyLists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class videoWidget extends StatelessWidget {
  const videoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<DataProvider>(context, listen: false)
            .fetchVideoMedias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  SizedBox(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(right:10.0),
                      child: Loading(width: 180,),
                    );
                  },),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final videos = Provider.of<DataProvider>(context).videoMedias;
            return videos.isEmpty
                ? const EmptyList('ရုပ်သံ တရားတော်မရှိသေးပါဗျာ')
                : SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: videos.length,
                        itemBuilder: (context, i) {
                          return video(videos[i], context, 180, 120);
                        }),
                  );

            // Row(
            //     children: [
            //       ...videos.map((e) => video(e, context,180,120)).toList(),
            //       InkWell(
            //         onTap: () {
            //           Navigator.of(context).push(
            //             fadePageRoute(
            //               'videoList',
            //               videoScreen.Video(),
            //             ),
            //           );
            //         },
            //         borderRadius: BorderRadius.circular(10),
            //         child: Container(
            //             height: 120,
            //             width: 180,
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.grey),
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: const Text('ထပ်ကြည့်ရန်')),
            //       ),
            //     ],
            //   );
          }
          return const Center(
            child: Text('What Happending?'),
          );
        });
  }
}



Widget video(Video video, BuildContext context, double width, double height) {
  return Padding(
    padding: const EdgeInsets.only(right:10.0),
    child: InkWell(
      onTap: () {
        Navigator.of(context)
            .push(fadePageRoute('videoDetail', VideoDetail(video)));
      },
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                        child: Loading(width: 180,),
                      ),
                  fit: BoxFit.cover,
                  imageUrl: video.thumbnail),
            ),
          ),
          const Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            top: 0,
            child: Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 40,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
