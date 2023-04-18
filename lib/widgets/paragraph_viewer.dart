import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';

class ParagraphViewer extends StatefulWidget {
  final List<MarkdownElement> elements;

  const ParagraphViewer({Key? key, required this.elements}) : super(key: key);

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
    List<TextSpan>? textSpans;
    for (MarkdownElement item in widget.elements) {
      //if item is not `Emphasis` or `MarkdownText`, need to set textSpans null
      if (item is MarkdownImage) {
        textSpans = null;
        paragraphList.add(item);
      }
      if (item is Emphasis) {
        TextStyle style;
        switch (item.type) {
          case EmphasisType.bold:
            style = const TextStyle(fontWeight: FontWeight.bold);
            break;
          case EmphasisType.italic:
            style = const TextStyle(fontStyle: FontStyle.italic);
            break;
          case EmphasisType.boldAndItalic:
            style = const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
            break;
          case EmphasisType.code:
            style = const TextStyle(backgroundColor: Colors.black12);
        }
        textSpans = _checkedTextSpans(textSpans, item.text, style);
      }
      if (item is MarkdownText) {
        textSpans = _checkedTextSpans(textSpans, item.text, null);
      }
    }
  }

  List<TextSpan> _checkedTextSpans(List<TextSpan>? textSpans, String text, TextStyle? style) {
    if (textSpans == null) {
      textSpans = [];
      paragraphList.add(textSpans);
    }
    textSpans.add(TextSpan(text: text, style: style));
    return textSpans;
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
            if (item is MarkdownImage) {
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
                  ),
                ],
              );
            }
            return const Text("\n");
          },
        ),
      ],
    );
  }
}
