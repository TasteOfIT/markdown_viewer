import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';

import 'block_quote_viewer.dart';
import 'heading_viewer.dart';
import 'horizontal_rule.dart';
import 'inline_viewer.dart';
import 'list_line_viewer.dart';
import 'paragraph_viewer.dart';
import 'preformatted_viewer.dart';

class BlockViewer extends StatelessWidget {
  final List<MarkdownElem> elements;
  final TextStyle? parentStyle;

  const BlockViewer({super.key, required this.elements, this.parentStyle});

  @override
  Widget build(BuildContext context) {
    if (elements.isEmpty) {
      return const SizedBox.shrink();
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: elements.length,
      itemBuilder: (BuildContext context, int position) {
        MarkdownElem item = elements[position];
        if (item is Rule) {
          return const HorizontalRule();
        }
        if (item is Heading) {
          return HeadingViewer(heading: item);
        }
        if (item is Paragraph) {
          return ParagraphViewer(paragraph: item, parentStyle: parentStyle);
        }
        if (item is Preformatted) {
          return PreformattedViewer(element: item);
        }
        if (item is BlockQuote) {
          return BlockQuoteViewer(blockQuote: item);
        }
        if (item is MarkdownListLine) {
          return ListLineViewer(listLine: item);
        }
        if (item is Inline) {
          return InlineViewer(elements: [item], parentStyle: parentStyle);
        }
        return Text(item.text, style: parentStyle);
      },
    );
  }
}
