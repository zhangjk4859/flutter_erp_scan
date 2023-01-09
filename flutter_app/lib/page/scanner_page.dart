import 'package:flutter/material.dart';
import 'package:flutter_app/widget/app_barcode_scanner_widget.dart';

///
/// ScannerPage
class ScannerPage extends StatefulWidget {
  static const String routeName = '/scanner';

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AppBarcodeScannerWidget.defaultStyle(
              resultCallback: (String code) {
                Navigator.of(context).pop(code);
              },
            ),
          ),
        ],
      ),
    );
  }
}
