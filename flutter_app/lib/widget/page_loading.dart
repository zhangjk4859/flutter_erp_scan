import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:loading_indicator_view/loading_indicator_view.dart';

class PageLoadding extends StatelessWidget {
  final bool loadding;
  final String noneText;

  PageLoadding(this.loadding, this.noneText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 100,
        child: loadding
            ? Column(
                children: [
                  BallBeatIndicator(
                    ballColor: Colors.blue,
                  ),
                ],
              )
            : Text(this.noneText));
  }
}
