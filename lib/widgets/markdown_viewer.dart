library markdown_viewer;

import 'package:flutter/material.dart';
import 'package:markdown_parser/element/element.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/widgets/heading_viewer.dart';
import 'package:markdown_viewer/widgets/markdown_list_viewer.dart';
import 'package:markdown_viewer/widgets/paragraph_viewer.dart';

class MarkdownViewer extends StatefulWidget {
  final String content;

  const MarkdownViewer({Key? key, required this.content}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MarkdownViewerState();
  }
}

class _MarkdownViewerState extends State<MarkdownViewer> {
  late List<MarkdownElement> elements;

  @override
  void initState() {
    super.initState();
    elements = MarkdownParser().parse(widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: elements.length,
        itemBuilder: (BuildContext context, int position) {
          MarkdownElement item = elements[position];
          if (item is Paragraph) {
            return ParagraphViewer(elements: item.children);
          }
          if (item is Heading) {
            return HeadingViewer(heading: item);
          }
          if (item is MarkdownList) {
            return MarkdownListViewer(markdownList: item);
          }
          return Text((item as MarkdownText).text);
        });
  }
}
