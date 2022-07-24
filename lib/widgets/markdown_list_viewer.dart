import 'package:flutter/widgets.dart';
import 'package:markdown_parser/element/element.dart';
import 'package:markdown_viewer/widgets/paragraph_viewer.dart';

class MarkDownListViewer extends StatefulWidget {
  late MarkDownList markdownList;

  MarkDownListViewer({Key? key, required this.markdownList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MDLState();
  }
}

class _MDLState extends State<MarkDownListViewer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.markdownList.data.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
          MarkDownListNode node = widget.markdownList.data[position];
          if (node.childContent != null && node.childContent is Paragraph) {
            return Wrap(
              direction: Axis.horizontal,
              children: [
                Row(
                  children: [
                    Text(_getPrefix(node)),
                    ParagraphViewer(
                        elements: (node.childContent as Paragraph).children)
                  ],
                )
              ],
            );
          }
          return const Text("\n");
        });
  }

  String _getPrefix(MarkDownListNode node) {
    String gap = "";
    String symbol = "";
    if (node.deep > 0) {
      gap = " ";
    }
    for (var i = 0; i <= node.deep; i++) {
      gap += gap;
    }
    if (node.type == ListType.unOrdered) {
      if (node.deep == 0) {
        symbol = "●";
      } else if (node.deep == 1) {
        symbol = "○";
      } else {
        symbol = "▪";
      }
    }
    if (node.type == ListType.ordered) {
      symbol = "${node.index + 1}. ";
    }
    return "$gap$symbol ";
  }
}
