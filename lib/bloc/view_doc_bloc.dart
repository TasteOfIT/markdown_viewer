import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:markdown_parser/markdown_parser.dart';

import '../models/doc.dart';

part 'view_doc_event.dart';

part 'view_doc_state.dart';

class ViewDocBloc extends Bloc<ViewDocEvent, ViewDocState> {
  final Future<Doc?> Function(String) _loadData;
  final MarkdownParser markdownParser = MarkdownParser();

  ViewDocBloc(this._loadData) : super(ViewDocLoading()) {
    on<LoadDoc>(_loadDoc);
  }

  void _loadDoc(LoadDoc event, Emitter<ViewDocState> emitter) async {
    Doc? doc = await _loadData(event.id);
    if (doc == null) {
      emit(ViewDocError("No content with id ${event.id}"));
    } else {
      emit(DocTitleLoaded(doc.title));
      List<MarkdownElem> elements = markdownParser.parse(doc.content);
      emit(DocContentLoaded(doc.title, elements));
    }
  }
}
