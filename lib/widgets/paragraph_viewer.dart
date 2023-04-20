import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/utils/text_styles.dart';

class ParagraphViewer extends StatefulWidget {
  final List<MarkdownElement> elements;
  final bool isQuote;

  const ParagraphViewer({
    Key? key,
    required this.elements,
    this.isQuote = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ParagraphViewerState();
  }
}

class _ParagraphViewerState extends State<ParagraphViewer> {
  List paragraphList = [];

  @override
  void initState() {
    super.initState();
    List<TextSpan> groupedText = List.empty(growable: true);
    for (MarkdownElement item in widget.elements) {
      if (item is ImageLink) {
        paragraphList.add(groupedText.sublist(0));
        groupedText.clear();
        paragraphList.add(item);
      } else if (textStyles.containsKey(item.type)) {
        groupedText.addAll(_createTextSpan(item));
      }
    }
    if (groupedText.isNotEmpty) {
      paragraphList.add(groupedText.sublist(0));
    }
  }

  List<TextSpan> _createTextSpan(MarkdownElement item) {
    String text = item.text;
    TextStyle? style = textStyles[item.type];
    if (item.type == ElementType.code) {
      return [
        const TextSpan(text: ' '),
        TextSpan(text: text, style: style),
        const TextSpan(text: ' '),
      ];
    }
    if (item.type == ElementType.link) {
      var recognizer = TapGestureRecognizer()
        ..onTapDown = (details) {
          // add pressed state
        }
        ..onTapUp = (details) {
          // remove pressed state
        };
      return [TextSpan(text: text, style: style, recognizer: recognizer)];
    }
    return [TextSpan(text: text, style: style)];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...List.generate(
          paragraphList.length,
          (index) {
            var item = paragraphList[index];
            if (item is ImageLink) {
              return Image.network(
                item.address,
                fit: BoxFit.scaleDown,
              );
            }
            if (item is List<TextSpan>) {
              return Wrap(
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: item,
                    ),
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
