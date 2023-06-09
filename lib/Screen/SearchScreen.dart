import '../Helper/fadePageRoute.dart';
import '../Modal/Audio.dart';
import '../Modal/BLog.dart';
import '../Modal/Pdf.dart';
import '../Modal/Video.dart';
import '../Provider/MusicProvider.dart';
import '../Provider/SearchProvider.dart';
import '../Screen/BLogDetail.dart';
import '../Screen/PdfDetail.dart';
import '../Screen/VideoDetail.dart';
import '../Utlis/SnackBar.dart';
import '../Widgets/FloatingMusicPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('load more');
        Provider.of<SearchProvider>(context, listen: false)
            .loadMoreMedias(_controller.text);
        // Load more data
        // Your data loading function here
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          padding:const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 242, 242, 242),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              isDense: true,
              focusColor: Color.fromARGB(255, 218, 218, 218),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.text = '';
                    });
                  },
                  icon: const Icon(Icons.close_outlined)),
              hintText: 'တရားများ ရှာဖွေရန်',

              border: InputBorder.none,

            ),
          ),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              if (_controller.text.isEmpty) {
                SnackBarWidget(context, 'ရှာဖွေချင်သော စကားလုံးထည့်ပါ');
                return;
              }
              Provider.of<SearchProvider>(context, listen: false)
                  .fetchMedias(_controller.text);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ရှာကြည့်မည်',
                style: TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Consumer<SearchProvider>(
          builder: (context, value, child) {
            return value.searchMedias.isEmpty
                ? const Center(child: Text('မတွေ့ ရှိသေးပါ'))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: value.searchMedias.length + 1,
                    itemBuilder: (context, i) {
                      if (value.searchMedias.length == i) {
                        return value.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : value.noDataLoad
                                ? const Center(child: Text('မတွေ့ရှိတော့ပါ'))
                                : Container();
                      }
                      var children2 = [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.searchMedias[i].name,
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'အမျိူးအစား : ${value.searchMedias[i].category}',
                            )
                          ],
                        ),
                        value.searchMedias[i].audio != null
                            ? value.searchMedias[i].id ==
                                    Provider.of<MusicProvider>(context)
                                        .singleAudio
                                        ?.id
                                ? IconButton(
                                    onPressed: () {
                                      Provider.of<MusicProvider>(context,
                                              listen: false)
                                          .pause();
                                    },
                                    icon: const Icon(Icons.pause_circle_filled),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      final Audio audio = Audio.fromJson(
                                          value.searchMedias[i].toJson());
                                      Provider.of<MusicProvider>(context,
                                              listen: false)
                                          .play(audio);
                                    },
                                    icon: const Icon(
                                        Icons.play_circle_fill_outlined),
                                  )
                            : IconButton(
                                onPressed: () {
                                  if (value.searchMedias[i].video != null) {
                                    final Video video = Video.fromJson(
                                        value.searchMedias[i].toJson());
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoDetail(video)));
                                    // Navigator.of(context).push(
                                    //   fadePageRoute(
                                    //     'videoDetail',
                                    //     VideoDetail(video),
                                    //   ),
                                    // );
                                    return;
                                  }

                                  if (value.searchMedias[i].photos != null) {
                                    final Blog blog = Blog.fromJson(
                                        value.searchMedias[i].toJson());

                                    Navigator.of(context).push(
                                      fadePageRoute(
                                        'blogDetail',
                                        blogDetail(blog),
                                      ),
                                    );
                                  }

                                  if (value.searchMedias[i].pdf != null) {
                                    final Pdf pdf = Pdf.fromJson(
                                        value.searchMedias[i].toJson());

                                    Navigator.of(context).push(
                                      fadePageRoute(
                                        'pdfDetail',
                                        PdfDetail(pdf),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(CupertinoIcons.right_chevron),
                              ),
                      ];
                      return Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: children2,
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingMusicPlayer(),
    );
  }
}
