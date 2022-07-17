import 'package:flutter/widgets.dart';
import 'package:markdown_parser/element/element.dart';

class HeadingViewer extends StatelessWidget {
  static const double minHeadingFontSize = 14.0;
  static const int hadingTypeSize = 6;
  final Heading heading;

  const HeadingViewer({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: heading.text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: minHeadingFontSize / (heading.level / hadingTypeSize),
        )));
  }
}
