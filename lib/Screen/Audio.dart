
import '../Helper/fadePageRoute.dart';
import '../Modal/subCategory.dart';
import '../Provider/AudioProvider.dart';
import '../Screen/AudioDetail.dart';
import '../Widgets/subCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Audio extends StatelessWidget {
  Audio({super.key});

  void showDetail(
    BuildContext context,
    int subCategoryId,
    String subCategoryName,
  ) {
    Navigator.of(context).push(
      fadePageRoute(
        'audioDetail',
        AudioDetail(subCategoryId, subCategoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('အသံတရားတော်များ'),
      ),
      body: FutureBuilder(
        future: Provider.of<AudioProvider>(context, listen: false)
            .fetchAudioSubCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<subCategory> categories =
                Provider.of<AudioProvider>(context).categories;
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
