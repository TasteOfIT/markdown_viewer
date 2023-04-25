import 'package:flutter/material.dart';
import 'package:markdown_parser/element/element.dart';

import '../utils/colors.dart';
import 'block_viewer.dart';

const _paddingWithBorder = 12.0;
const _paddingNoBorder = 4.0;

class BlockQuoteViewer extends StatelessWidget {
  final BlockQuote blockQuote;
  final TextStyle? parentStyle;

  const BlockQuoteViewer({super.key, required this.blockQuote, this.parentStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(backgroundQuote),
      foregroundDecoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Color(leadingQuote), width: 6.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: _paddingWithBorder,
          right: _paddingNoBorder,
          top: _paddingNoBorder,
          bottom: _paddingNoBorder,
        ),
        child: BlockViewer(elements: blockQuote.children, parentStyle: parentStyle),
      ),
    );
  }
}
