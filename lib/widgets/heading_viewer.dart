import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/widgets/paragraph_viewer.dart';

import '../utils/text_styles.dart';

class HeadingViewer extends StatelessWidget {
  final Heading heading;

  const HeadingViewer({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ParagraphViewer(
      paragraph: heading,
      parentStyle: _headingStyle(context, heading.level),
      maxLines: 1,
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
      return fallbackHeading.copyWith(inherit: true, overflow: TextOverflow.ellipsis);
    } else {
      return style.copyWith(inherit: true, overflow: TextOverflow.ellipsis);
    }
  }
}
