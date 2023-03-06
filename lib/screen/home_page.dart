import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String name = "";
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter PDF Viewer'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult = _pdfViewerController.searchText(name,
                    searchOption: TextSearchOption.caseSensitive);
                if (kIsWeb) {
                  print(
                      'Total instance count: ${_searchResult.totalInstanceCount}');
                } else {
                  _searchResult.addListener(() {
                    if (_searchResult.hasResult &&
                        _searchResult.isSearchCompleted) {
                      print(
                          'Total instance count: ${_searchResult.totalInstanceCount}');
                    }
                  });
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              onChanged: (value) {
                name = value;
              },
            ),
            Expanded(
              child: SfPdfViewer.network(
                  'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                  controller: _pdfViewerController),
            ),
          ]
        ));
  }
}
