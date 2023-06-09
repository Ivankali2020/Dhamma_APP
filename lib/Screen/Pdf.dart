import '../Helper/fadePageRoute.dart';
import '../Modal/subCategory.dart';
import '../Provider/PdfProvider.dart';
import '../Screen/PdfListBySuCategory.dart';
import '../Widgets/subCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pdf extends StatelessWidget {
  Pdf({super.key});

  void showDetail(
    BuildContext context,
    int subCategoryId,
    String subCategoryName,
  ) {
    Navigator.of(context).push(
      fadePageRoute(
        'pdfdetail',
        PdfListBySuCategory(subCategoryId, subCategoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('တရားစာပေများ'),
      ),
      body: FutureBuilder(
        future: Provider.of<PdfProvider>(context, listen: false)
            .fetchPdfSubCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<subCategory> categories =
                Provider.of<PdfProvider>(context).categories;
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
