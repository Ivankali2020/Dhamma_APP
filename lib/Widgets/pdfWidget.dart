import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhamma/Utlis/Loading.dart';
import '../Helper/fadePageRoute.dart';
import '../Modal/Pdf.dart';
import '../Provider/DataProvider.dart';
import '../Screen/PdfDetail.dart';
import '../Utlis/EmptyLists.dart';
import '../Screen/Pdf.dart' as PdfScreen;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class pdfWidget extends StatelessWidget {
  const pdfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<DataProvider>(context, listen: false).fetchPdfMedias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 240,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Loading(
                        width: 120,
                      ),
                    );
                  }),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final pdfs = Provider.of<DataProvider>(context).pdfMedias;
            return pdfs.isEmpty
                ? const EmptyList('စာပေ တရားတော်မရှိသေးပါ')
                : SizedBox(
                    height: 240,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pdfs.length,
                        itemBuilder: (context, i) {
                          return pdf(pdfs[i], context);
                        }),
                  );

            // Row(
            //     children: [
            //       ...pdfs.map((e) => pdf(e, context)).toList(),
            //       InkWell(
            //         onTap: () {
            //           Navigator.of(context).push(
            //             fadePageRoute(
            //               'pdfScreen',
            //               PdfScreen.Pdf(),
            //             ),
            //           );
            //         },
            //         borderRadius: BorderRadius.circular(10),
            //         child: Container(
            //           height: 240,
            //           width: 150,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //               border: Border.all(color: Colors.grey),
            //               borderRadius: BorderRadius.circular(10)),
            //           child: const Text('ထပ်ကြည့်ရန်'),
            //         ),
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

Widget pdf(Pdf pdf, BuildContext context) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: () {
      Navigator.of(context).push(
        fadePageRoute('pdfDetail', PdfDetail(pdf), arguments: {'data': pdf}),
      );
    },
    child: Stack(
      children: [
        Container(
          height: 240,
          width: 150,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: Loading(
                        width: 240,
                      ),
              ),
              fit: BoxFit.cover,
              imageUrl: pdf.thumbnail,
            ),
          ),
        ),
        const Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          top: 0,
          child: Icon(
            Icons.play_arrow,
            color: Color.fromARGB(255, 232, 231, 231),
            size: 40,
          ),
        )
      ],
    ),
  );
}
