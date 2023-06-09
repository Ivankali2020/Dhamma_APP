import '../Helper/fadePageRoute.dart';
import '../Modal/subCategory.dart';
import '../Provider/VideoProvider.dart';
import '../Screen/VideoListBySuCategory.dart';
import '../Widgets/subCategoryWidget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Video extends StatelessWidget {
  Video({super.key});

  void showDetail(
    BuildContext context,
    int subCategoryId,
    String subCategoryName,
  ) {
    Navigator.of(context).push(
      fadePageRoute(
        'audioDetail',
        VideoListBySuCategory(subCategoryId, subCategoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ရုပ်သံတရားတော်များ'),
      ),
      body: FutureBuilder(
        future: Provider.of<VideoProvider>(context, listen: false)
            .fetchVideoSubCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<subCategory> categories =
                Provider.of<VideoProvider>(context).categories;

            return categories.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: subCategoryWidget(categories, showDetail),
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
