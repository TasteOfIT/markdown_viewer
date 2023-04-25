import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_parser/markdown_parser.dart';

import '../bloc/view_doc_bloc.dart';
import 'block_viewer.dart';

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
  List<MarkdownElem> _elements = List.empty();

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

  Widget _docView(List<MarkdownElem> elements) {
    return BlockViewer(elements: elements);
  }
}
