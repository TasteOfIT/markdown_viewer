import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';

import '../utils/colors.dart';

const _cornerRadius = 4.0;
const _padding = 6.0;
const _margin = 4.0;

class PreformattedViewer extends StatelessWidget {
  final Preformatted element;

  const PreformattedViewer({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    if (element.content.type == ElemType.code) {
      return IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox.fromSize(size: const Size.fromHeight(_margin)),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(_cornerRadius)),
              child: ColoredBox(
                color: const Color(backgroundCode),
                child: Padding(
                  padding: const EdgeInsets.all(_padding),
                  child: Text(
                    element.content.text.trimRight(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.0,
                        ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(size: const Size.fromHeight(_margin)),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
