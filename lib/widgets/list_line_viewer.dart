import 'dart:math';

import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';

import '../utils/bullet_generator.dart';
import 'block_viewer.dart';

class ListLineViewer extends StatelessWidget {
  final MarkdownListLine listLine;
  final TextStyle? parentStyle;

  const ListLineViewer({Key? key, required this.listLine, this.parentStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listLine.children.isNotEmpty) {
      return Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getPrefix(listLine.listInfo, listLine.index),
            style: Theme.of(context).textTheme.bodyLarge?.merge(parentStyle),
            textAlign: TextAlign.right,
          ),
          const Padding(padding: EdgeInsets.all(4.0)),
          Flexible(
            child: BlockViewer(elements: listLine.children, parentStyle: parentStyle),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  String _getPrefix(ListInfo info, int index) {
    StringBuffer gap = StringBuffer();
    StringBuffer symbol = StringBuffer();
    for (var i = 0; i < info.depth; i++) {
      gap.write('    ');
    }
    switch (info.listType) {
      case ListType.unOrdered:
        symbol.write(getBulletUnordered(min(info.depth, 2)));
        break;
      case ListType.ordered:
        symbol.write(getBulletOrdered(index + 1, min(info.depth, 2)));
        break;
    }
    return "$gap$symbol";
  }
}
