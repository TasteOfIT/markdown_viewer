import 'package:flutter/material.dart';
import 'package:markdown_parser/element/element.dart';

class ParagraphViewer extends StatefulWidget {
  final List<MarkDownElement> elements;

  const ParagraphViewer({Key? key, required this.elements}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ParagraphViewerState();
  }
}

class _ParagraphViewerState extends State<ParagraphViewer> {
  List<TextSpan> textSpans = [];

  @override
  void initState() {
    super.initState();
    for (MarkDownElement item in widget.elements) {
      TextStyle style;
      if (item is Emphasis) {
        switch (item.type) {
          case EmphasisType.bold:
            style = const TextStyle(fontWeight: FontWeight.bold);
            break;
          case EmphasisType.italic:
            style = const TextStyle(fontStyle: FontStyle.italic);
            break;
          case EmphasisType.boldAndItalic:
            style = const TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
            break;
          case EmphasisType.code:
            style = const TextStyle(backgroundColor: Colors.black12);
        }
        textSpans.add(TextSpan(text: item.text, style: style));
      }
      if (item is UnParsed) {
        textSpans.add(TextSpan(text: item.text));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: textSpans,
      ),
    );
  }
}
