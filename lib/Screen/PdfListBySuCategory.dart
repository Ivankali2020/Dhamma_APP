import 'package:dhamma/Utlis/Logo.dart';

import '../Modal/Pdf.dart';
import '../Provider/PdfProvider.dart';
import '../Widgets/pdfWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PdfListBySuCategory extends StatelessWidget {
  final int subCategoryId;
  final String subCategroyName;
  PdfListBySuCategory(this.subCategoryId, this.subCategroyName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Logo(),
        title: Text(subCategroyName),
      ),
      body: FutureBuilder(
        future: Provider.of<PdfProvider>(context, listen: false)
            .fetchPdfMediasBySubCategory(subCategoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<Pdf> pdfs = Provider.of<PdfProvider>(context).pdfMedias;
            return pdfs.isEmpty
                ? const Center(
                    child: Text('မတွေ့ရှိပါ ခင်ဗျာ'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: pdfs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 200, crossAxisCount: 3),
                      itemBuilder: (context, i) {
                        return pdf(pdfs[i], context);
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
