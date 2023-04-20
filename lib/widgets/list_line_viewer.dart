import 'dart:math';

import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/utils/bullet_generator.dart';

import './paragraph_viewer.dart';

class ListLineViewer extends StatelessWidget {
  final MarkdownListLine markdownListLine;

  const ListLineViewer({Key? key, required this.markdownListLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (markdownListLine.children.isNotEmpty) {
      return Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_getPrefix(markdownListLine), style: Theme.of(context).textTheme.bodyLarge),
          Flexible(child: ParagraphViewer(elements: (markdownListLine.children.first).children)),
        ],
      );
    } else {
      return const Text('\n');
    }
  }

  String _getPrefix(MarkdownListLine node) {
    ListInfo info = node.listInfo;
    String gap = "";
    String symbol = "";
    if (info.depth > 0) {
      gap = " ";
    }
    for (var i = 0; i <= info.depth; i++) {
      gap += gap;
    }
    switch (info.listType) {
      case ListType.unOrdered:
        symbol = getBulletUnordered(min(info.depth, 2));
        break;
      case ListType.ordered:
        symbol = getBulletOrdered(node.index + 1, min(info.depth, 2));
        break;
    }
    return "$gap$symbol ";
  }
}
