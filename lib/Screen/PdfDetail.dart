
import '../Modal/Pdf.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfDetail extends StatefulWidget {
  final Pdf pdf;
  PdfDetail(this.pdf);

  @override
  State<PdfDetail> createState() => _PdfDetailState();
}

class _PdfDetailState extends State<PdfDetail> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdf.name),
      ),
      body: Container(child:SfPdfViewer.network(widget.pdf.pdf),),
    );
  }
}
