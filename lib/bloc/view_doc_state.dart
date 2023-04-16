part of 'view_doc_bloc.dart';

abstract class ViewDocState extends Equatable {
  const ViewDocState();
}

class ViewDocLoading extends ViewDocState {
  @override
  List<Object?> get props => [];
}

class DocTitleLoaded extends ViewDocState {
  const DocTitleLoaded(this.title) : super();

  final String title;

  @override
  List<Object?> get props => [title];
}

class DocContentLoaded extends ViewDocState {
  const DocContentLoaded(this.title, this.elements) : super();

  final String title;

  final List<MarkdownElement> elements;

  @override
  List<Object?> get props => [title, elements];
}

class ViewDocError extends ViewDocState {
  const ViewDocError(this.message) : super();

  final String message;

  @override
  List<Object?> get props => [message];
}
