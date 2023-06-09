import 'package:dhamma/Utlis/Logo.dart';

import '../Modal/Video.dart';
import '../Provider/VideoProvider.dart';
import '../Widgets/videoWidget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoListBySuCategory extends StatelessWidget {
  final int subCategoryId;
  final String subCategroyName;
  VideoListBySuCategory(this.subCategoryId, this.subCategroyName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Logo(),
        title: Text(subCategroyName),
      ),
      body: FutureBuilder(
        future: Provider.of<VideoProvider>(context, listen: false)
            .fetchVideoMediasBySubCategory(subCategoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<Video> videos =
                Provider.of<VideoProvider>(context).VideoMedias;
            return videos.isEmpty
                ? const Center(
                    child: Text('မတွေ့ရှိပါ ခင်ဗျာ'),
                  )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.only(bottom:8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.grey),
                            borderRadius: BorderRadius.circular(11)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              video(videos[i], context,160,100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(videos[i].name,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 10,),
                                  Text(videos[i].category),
                                  const SizedBox(height: 5,),
                                  Text(videos[i].subCategory),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                );
          }

          return const Center(
            child: Text('What Happened?'),
          );
        },
      ),
    );
  }
}
