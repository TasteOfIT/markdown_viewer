import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/utils/text_styles.dart';

class InlineViewer extends StatelessWidget {
  final List<Inline> elements;
  final TextStyle? parentStyle;
  final int? maxLines;

  const InlineViewer({Key? key, required this.elements, this.parentStyle, this.maxLines}) : super(key: key);

  List _buildUiStyles() {
    final List stylesList = [];
    List<TextSpan> groupedText = List.empty(growable: true);
    for (Inline item in elements) {
      if (item is ImageLink) {
        stylesList.add(groupedText.sublist(0));
        groupedText.clear();
        stylesList.add(item);
      } else if (textStyles.containsKey(item.type)) {
        groupedText.add(_createTextSpan(item, parentStyle));
      }
    }
    if (groupedText.isNotEmpty) {
      stylesList.add(groupedText.sublist(0));
    }
    return stylesList;
  }

  TextSpan _codeSpan(String text, TextStyle? style) {
    return TextSpan(text: ' ${text.trim()} ', style: style);
  }

  TextSpan _linkSpan(Inline item, TextStyle? style) {
    var recognizer = TapGestureRecognizer()
      ..onTapDown = (details) {
        // add pressed state
      }
      ..onTapUp = (details) {
        // remove pressed state
      };
    UrlLink link = item as UrlLink;
    if (link.spanChildren.isNotEmpty) {
      return TextSpan(
        children: link.spanChildren.map((child) => _createTextSpan(child, style)).toList(),
      );
    }
    return TextSpan(text: item.text, style: style, recognizer: recognizer);
  }

  TextSpan _createTextSpan(Inline item, TextStyle? parentStyle) {
    String text = item.text;
    TextStyle? style = textStyles[item.type]?.merge(parentStyle);
    if (item.type == ElemType.code) {
      return _codeSpan(text, style);
    }
    if (item.type == ElemType.link) {
      return _linkSpan(item, style);
    }
    if (item.spanChildren.isNotEmpty) {
      // handle embedding inline
      return TextSpan(
        children: item.spanChildren.map((child) => _createTextSpan(child, style)).toList(),
      );
    }
    return TextSpan(text: text, style: style);
  }

  @override
  Widget build(BuildContext context) {
    var stylesList = _buildUiStyles();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...List.generate(
          stylesList.length,
          (index) {
            var item = stylesList[index];
            if (item is ImageLink) {
              return Image.network(item.src, fit: BoxFit.scaleDown);
            }
            if (item is List<TextSpan>) {
              return Wrap(
                children: [
                  RichText(
                    text: TextSpan(
                      children: item,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    maxLines: maxLines,
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
