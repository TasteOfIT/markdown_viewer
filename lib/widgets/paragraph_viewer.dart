import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/widgets/inline_viewer.dart';

class ParagraphViewer extends StatelessWidget {
  final Paragraph paragraph;
  final TextStyle? parentStyle;
  final int? maxLines;

  const ParagraphViewer({Key? key, required this.paragraph, this.parentStyle, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InlineViewer(
      elements: paragraph.children,
      parentStyle: parentStyle,
      maxLines: maxLines,
    );
  }
}
