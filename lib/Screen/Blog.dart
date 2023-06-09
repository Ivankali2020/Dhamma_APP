
import '../Helper/fadePageRoute.dart';
import '../Modal/subCategory.dart';
import '../Provider/BlogProvider.dart';
import '../Provider/PdfProvider.dart';
import '../Screen/BlogListBySuCategory.dart';
import '../Screen/PdfListBySuCategory.dart';
import '../Widgets/subCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Blog extends StatelessWidget {
  Blog({super.key});

  void showDetail(
    BuildContext context,
    int subCategoryId,
    String subCategoryName,
  ) {
    Navigator.of(context).push(
      fadePageRoute(
        'blogDetail',
        BlogListBySuCategory(subCategoryId, subCategoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('မှတ်တမ်းမှတ်ရာများ'),
      ),
      body: FutureBuilder(
        future: Provider.of<BlogProvider>(context, listen: false)
            .fetchBlogSubCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<subCategory> categories =
                Provider.of<BlogProvider>(context).categories;
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
