import 'dart:math';

import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/utils/bullet_generator.dart';

import './paragraph_viewer.dart';

class MarkdownListViewer extends StatefulWidget {
  late MarkdownList markdownList;

  MarkdownListViewer({Key? key, required this.markdownList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MDLState();
  }
}

class _MDLState extends State<MarkdownListViewer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.markdownList.data.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
          MarkdownListNode node = widget.markdownList.data[position];
          if (node.childContent != null && node.childContent is Paragraph) {
            return Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_getPrefix(node), style: Theme.of(context).textTheme.bodyLarge),
                Flexible(child: ParagraphViewer(elements: (node.childContent as Paragraph).children))
              ],
            );
          }
          return const Text("\n");
        });
  }

  String _getPrefix(MarkdownListNode node) {
    String gap = "";
    String symbol = "";
    if (node.depth > 0) {
      gap = " ";
    }
    for (var i = 0; i <= node.depth; i++) {
      gap += gap;
    }
    if (node.type == ListType.unOrdered) {
      symbol = getBulletUnordered(min(node.depth, 2));
    }
    if (node.type == ListType.ordered) {
      symbol = getBulletOrdered(node.index + 1, min(node.depth, 2));
    }
    return "$gap$symbol ";
  }
}
