import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';

class HeadingViewer extends StatelessWidget {
  static const double minFontSize = 8.0;
  final Heading heading;

  const HeadingViewer({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: heading.text,
        style: _headingStyle(context, heading.level),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  TextStyle _headingStyle(BuildContext context, int level) {
    final TextStyle? style;
    switch (level) {
      case 1:
        style = Theme.of(context).textTheme.displayLarge;
        break;
      case 2:
        style = Theme.of(context).textTheme.displayMedium;
        break;
      case 3:
        style = Theme.of(context).textTheme.displaySmall;
        break;
      case 4:
        style = Theme.of(context).textTheme.headlineMedium;
        break;
      case 5:
        style = Theme.of(context).textTheme.headlineSmall;
        break;
      case 6:
        style = Theme.of(context).textTheme.titleMedium;
        break;
      default:
        style = Theme.of(context).textTheme.titleSmall;
        break;
    }
    if (style == null) {
      return const TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: minFontSize,
        fontWeight: FontWeight.w300,
      );
    } else {
      return style;
    }
  }
}
