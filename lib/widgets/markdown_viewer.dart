import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_parser/markdown_parser.dart';

import './heading_viewer.dart';
import './paragraph_viewer.dart';
import './preformatted_viewer.dart';
import '../bloc/view_doc_bloc.dart';
import '../widgets/list_line_viewer.dart';

class MarkdownViewer extends StatefulWidget {
  final String noteId;
  final ViewDocBloc docBloc;
  final Function(String) titleUpdated;

  const MarkdownViewer(
    this.noteId,
    this.docBloc,
    this.titleUpdated, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MarkdownViewerState();
  }
}

class _MarkdownViewerState extends State<MarkdownViewer> {
  String _title = '';
  List<MarkdownElement> _elements = List.empty();

  @override
  void initState() {
    super.initState();
    widget.docBloc.add(LoadDoc(widget.noteId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewDocBloc, ViewDocState>(
      listener: (context, state) {
        if (state is ViewDocError) {
          Log.d(state.message);
        } else if (state is DocTitleLoaded) {
          _updateTitle(state.title);
        } else if (state is DocContentLoaded) {
          _updateTitle(state.title);
          setState(() {
            _elements = state.elements;
          });
        }
      },
      child: _docView(_elements),
    );
  }

  void _updateTitle(String title) {
    if (_title.isNotEmpty) return;
    setState(() {
      _title = title;
    });
    widget.titleUpdated(title);
  }

  Widget _docView(List<MarkdownElement> elements) {
    return ListView.builder(
      itemCount: elements.length,
      itemBuilder: (BuildContext context, int position) {
        MarkdownElement item = elements[position];
        if (item is Heading) {
          return HeadingViewer(heading: item);
        }
        if (item is Paragraph) {
          return ParagraphViewer(elements: item.children);
        }
        if (item is MarkdownListLine) {
          return ListLineViewer(markdownListLine: item);
        }
        if (item is Preformatted) {
          return PreformattedViewer(element: item);
        }
        return Text((item as Plain).text);
      },
    );
  }
}
